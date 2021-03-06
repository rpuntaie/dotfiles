#https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
#modified
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}
fzf-down() {
  fzf --height 50% "$@" --border
}
fzf_gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}
fzf_gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) -- | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}
# fzf_gt() {
#   is_in_git_repo || return
#   git tag --sort -version:refname |
#   fzf-down --multi --preview-window right:70% \
#     --preview 'git show --color=always {} | head -'$LINES
# }
fzf_gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | head -1 | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}" | head -1
}
# fzf_gr() {
#   is_in_git_repo || return
#   git remote -v | awk '{print $1 "\t" $2}' | uniq |
#   fzf-down --tac \
#     --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" --remotes={1} | head -200' |
#   cut -d$'\t' -f1
# }
join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}
bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(fzf_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^$c' fzf-g$c-widget"
  done
}
bind-git-helper f h b
unset -f bind-git-helper

# https://github.com/junegunn/fzf#Settings
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'
# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

