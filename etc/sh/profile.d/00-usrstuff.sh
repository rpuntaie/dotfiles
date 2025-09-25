
# user data separate directories
# ~/.gnupg, ~/.password-store, ~/my and these ~/dotfiles
# export MY="${HOME}/my" # defined in /etc/security/pam_env.conf (which needs empty line at end of file)
export $(envsubst < $MY/.env)

export OPENAI_API_TOKEN="$(pass show platform.openai.com/apikey)"
export OPENAI_KEY="$(pass show platform.openai.com/apikey)"
export GEMINI_API_KEY="$(pass show google/GEMINI_API_KEY)"
export INVOKEAI_ROOT="$HOME/invokeai"
export GH_TOKEN="$(pass show token_github.com/rpuntaie)"
export Y2="$(date +%y)"
export Y4="$(date +%Y)"
