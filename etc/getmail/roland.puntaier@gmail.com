#directly via getmail
#getmail --rcfile=roland.puntaier@gmail.com --getmaildir=/home/roland/.local/etc/getmail

[retriever]
type = SimpleIMAPSSLRetriever
server = imap.gmail.com
username = roland.puntaier@gmail.com
port = 993
#use_xoauth2 = True
#password_command = ("getmail-gmail-xoauth-tokens", "/home/roland/roland.puntaier@gmail.com.json")
#contains app password, available after activating Google 2-Step Verification:
password_command = ("pass", "mailwizard-roland.puntaier@gmail.com")

# #MWNOTMUCHNEW=1 will call notmuch and afew to move mails to folders
# [destination]
# type = Maildir
# path = /home/roland/Mail/roland.puntaier@gmail.com/INBOX/

# procmail moves mails to folder
# else manually via e.g.
# mv `rg -l From.*youtube.com` ../../_/youtube/cur/
[destination]
type = MDA_external
path = /usr/bin/procmail
arguments = ('-f', '%(sender)', '-m', '/home/roland/.local/etc/procmail/roland.puntaier@gmail.com')

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

