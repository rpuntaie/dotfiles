MAILDIR=$MAILDIR/dontbite71@gmail.com
DEFAULT=\$MAILDIR/INBOX

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
\$DEFAULT/
