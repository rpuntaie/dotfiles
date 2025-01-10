
# user data separate directories
# ~/.gnupg, ~/.password-store, ~/my and these ~/dotfiles
export MY="${HOME}/my"
export TASKDATA="${MY}/task"
export FINANCE="${MY}/finance"

export Y2="$(date +%y)"
export Y4="$(date +%Y)"

# environment variables usrstuff:
export REALNAME="Roland Puntaier"
export EMAIL="roland.puntaier@gmail.com"
export GPGKEY="F85CB631327ED8DCD50C9FD3BC9A552643B86228"

# mailwizard without notmuch call
export MWNOTMUCHNEW=0

export OPENAI_API_TOKEN="$(pass show platform.openai.com/apikey)"
export OPENAI_KEY="$(pass show platform.openai.com/apikey)"
export INVOKEAI_ROOT="$HOME/invokeai"

export GH_TOKEN="$(pass show token_github.com/rpuntaie)"

export COMPANY="vougee"

export OLLAMA_HOST=0.0.0.0
export OLLAMA_MODELS="/home/roland/msrc/models_manually"
