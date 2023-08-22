
# user data separate directories
# ~/.gnupg, ~/.password-store, ~/my and these ~/dotfiles
export MY="${HOME}/my"
export TASKDATA="${MY}/task"
export FINANCE="${MY}/finance"

# environment variables usrstuff:
export REALNAME="Roland Puntaier"
export EMAIL="roland.puntaier@gmail.com"
export GPGKEY="F85CB631327ED8DCD50C9FD3BC9A552643B86228"

# mailwizard without notmuch call
export MWNOTMUCHNEW=0

scp1(){scp $2 roland@192.168.1.$1:/home/roland/tmp/}

export OPENAI_API_TOKEN="$(pass show platform.openai.com/apikey)"
export OPENAI_KEY="$(pass show platform.openai.com/apikey)"
export INVOKEAI_ROOT="$HOME/invokeai"

