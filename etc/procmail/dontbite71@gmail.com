MAILDIR=/home/roland/Mail/dontbite71@gmail.com

:0
* ^From.*@.*youtube\.com
_/youtube/

:0
* ^From.*@.*google\.com
_/google/

:0
* ^From.*@.*github\.com
_/git/

:0
INBOX/
