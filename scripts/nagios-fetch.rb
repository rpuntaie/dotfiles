#!/usr/bin/env ruby

require 'optparse'
require 'httparty'
require 'nokogiri'

@notifier = '/usr/bin/notify-send'
@notifier_urgency_low = '--urgency=low'
@notifier_urgency_normal = '--urgency=normal'
@notifier_urgency_critical = '--urgency=critical'
@cgi = 'status.cgi'
@cgi_params = ''

class WrontHTTPCode < Exception
end

def parse_status_cgi(parsed_page)
  services = {
    ok: parsed_page.at_css('.serviceTotalsOK').content,
    warning: '0', #parsed_page.at_css('.serviceTotalsWARNING').content,
    unknown: parsed_page.at_css('.serviceTotalsUNKNOWN').content,
    critical: parsed_page.at_css('.serviceTotalsCRITICAL').content,
    pending: '0' #parsed_page.at_css('table.serviceTotalsPENDING').content
  }

  hosts = {
    up: parsed_page.at_css('.hostTotalsUP').content,
    down: parsed_page.at_css('.hostTotalsUP').content,
    unreacheable: parsed_page.css('table.hostTotals tr td.hostTotals').first,
    pending: parsed_page.css('table.hostTotals tr td.hostTotals').first
  }

  checks = Array.new
  parsed_page.css('html body table.status tr').each do |c|
    values = c.css('td')
    if values.size == 10
      c = {
        host: 'Unknow',
        name: values[3].content, # Check
        status: values[5].content, # status
        last_check: values[6].content, # last check
        duration: values[7].content, # duration
        attempt: values[8].content, # attempt
        status_information: values[9].content # status information
      }
      checks.push(c) if c[:status] != 'OK'
    end
  end

  data = {
    services: services,
    hosts: hosts,
    checks: checks
  }
end

# print to stdout
def print_stdout(data)
  services = data[:services]
  hosts = data[:services]
  checks = data[:checks]

  print "\n"
  puts '***** Services *****'
  puts 'OK : ' + services[:ok]
  puts 'WARNING : ' + services[:warning]
  puts 'CRITICAL : ' + services[:critical]
  puts 'PENDING : ' + services[:pending]

  print "\n"
  puts '***** Hosts *****'
  puts 'UP : ' + hosts[:ok]
  puts 'DOWN : ' + hosts[:warning]
  puts 'UNREACHEABLE : ' + hosts[:critical]
  puts 'PENDING : ' + hosts[:pending]

  print "\n"
  puts '***** Details (Failed only) *****'
  checks.each do |c|
    print c[:host] + ' // ' + c[:name] + ' // ' + c[:status] + ' // ' + c[:status_information] +  "\n"
  end
end

def notify(data, title)
  services = data[:services]
  total = services[:ok].to_i + services[:critical].to_i
          + services[:warning].to_i + services[:pending].to_i

  message = services[:ok] + '/' + total.to_s + ' services are OK.'
  send_notification('normal', title, message)

  if services[:critical].to_i > 0
    message = services[:critical] + '/' + total.to_s + ' services are in critical state !'
    send_notification('critical', title, message)
  end

  if services[:warning].to_i > 0
    message = services[:warning] + '/' + total.to_s + ' services are in warning state !'
    send_notification('critical', title, message)
  end

  if services[:pending].to_i > 0
    message = services[:pending] + '/' + total.to_s + ' services are in pending state.-'
    send_notification('critical', title, message)
  end
end

def send_notification(urgency, title, message)
  urgency_param = case urgency
                  when 'low'
                    @notifier_urgency_low
                  when 'critical'
                    @notifier_urgency_critical
                  else
                    @notifier_urgency_normal
                  end
  system(@notifier, urgency_param, title, message)
end

options = {}

# Parse arguments
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: nagios-fetch.rb -f URL [options]"

  opts.on('-f', '--fetch URL', 'Fetch from URL') do |host|
    options[:host] = host
  end

  opts.on('-n', '--notify',
          'Notify (notify-send)') do
    options[:notify] = true
    end

  opts.on('-t', '--title',
          'Title of the notifications') do |title|
    options[:title] = title
  end


  opts.on('-u', '--user USER',
          'HTTP basic auth using USER') do |user|
    options[:user] = user
  end

  opts.on('-p', '--password PWD', 'HTTP basic auth using PWD') do |pwd|
    options[:password] = pwd
  end

  opts.on('-h', '--help', 'Display this screen') do
    puts opts
    exit
  end
end
optparse.parse!

# Check missing arguments
raise OptionParser::MissingArgument if options[:host].nil?
if options[:user].nil? && !options[:password].nil?
  options[:user] = 'nagiosadmin'
end
if !options[:user].nil? && options[:password].nil?
  raise OptionParser::MissingArgument
end
options[:title] = options[:host] if options[:title].nil?

# Fetch
url = options[:host] + '/' + @cgi + @cgi_params
puts "Fetching #{url}."
begin
  page = if !options[:user].nil?
           auth = {:username => options[:user], :password => options[:password]}
           HTTParty.get(url, :basic_auth => auth)
         else
           HTTParty.get(url)
         end
  raise WrontHTTPCode, "#{page.code}" if page.code != 200
rescue WrontHTTPCode => e
  puts "The request returned " + e.message + "!"
  exit
rescue => e
  print "Failed to fetch `#{url}` ! \n > "
  puts e.message
  exit
end

# Parse
parsed_page = Nokogiri::HTML(page)
data = parse_status_cgi(parsed_page)

# Print or notify
unless options[:notify]
  print_stdout(data)
else
  notify(data, options[:title])
end
