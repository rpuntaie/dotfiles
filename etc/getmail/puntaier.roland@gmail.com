#directly via getmail
#getmail --rcfile=puntaier.roland@gmail.com --getmaildir=/home/roland/.local/etc/getmail

[retriever]
type = SimpleIMAPSSLRetriever
server = imap.gmail.com
username = puntaier.roland@gmail.com
#use_xoauth2 = True
#password_command = ("getmail-gmail-xoauth-tokens", "/home/roland/puntaier.roland@gmail.com.json")
#password_command = ("pass", "gmail/puntaier.roland@gmail.com")
password_command = ("pass", "google/app_password_gmail/puntaier.roland@gmail.com")

# #MWNOTMUCHNEW=1 will call notmuch and afew to move mails to folders
#[destination]
#type = Maildir
#path = /home/roland/Mail/puntaier.roland@gmail.com/INBOX/

# procmail moves mails to folder
# else manually via e.g.
# mv `rg -l From.*youtube.com` ../../_/youtube/cur/
[destination]
type = MDA_external
path = /usr/bin/procmail
arguments = ('-f', '%(sender)', '-m', '/home/roland/.local/etc/procmail/puntaier.roland@gmail.com')

[options]
read_all = true
delete = true
#message_log = /home/roland/.local/var/log/getmail.log

# #pacman -S spamassassin
# [filter-1]
# type = Filter_external
# path = /usr/bin/vendor_perl/spamc
# ignore_header_shrinkage = True
#
# #pacman -S clamav
# [filter-2]
# type = Filter_classifier
# path = /usr/bin/clamscan
# arguments = ("--stdout", "--no-summary",
#     "--scan-mail", "--infected", "-")
# exitcodes_drop = (1,)

# vim: ft=conf

