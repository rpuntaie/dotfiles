#if not super user:
#Couldn't get a file descriptor referring to the console
FNTCONSOLE=/usr/share/kbd/consolefonts/ter-powerline-v14b.psf.gz
if [[ -f $FNTCONSOLE ]]; then
    setfont $FNTCONSOLE
fi
