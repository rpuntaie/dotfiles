MAILDIR=/home/roland/Mail/puntaier.roland@gmail.com

:0
* ^From.*@.*youtube\.com
_/youtube/

:0
* ^Subject.*test
_/test/

:0
* ^From.*@.*google\.com
_/google/

:0
* ^From.*@.*github\.com
_/git/

:0
* ^To.*@.*pyropus\.ca
_/getmail/

:0
INBOX/
