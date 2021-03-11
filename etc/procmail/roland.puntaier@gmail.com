MAILDIR=$MAILDIR/roland.puntaier@gmail.com
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
* ^To.*@.*pyropus\.ca
_/getmail/

:0
\$DEFAULT/
