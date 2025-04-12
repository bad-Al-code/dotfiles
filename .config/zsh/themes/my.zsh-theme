function toon {
  echo -n ""
}

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' formats '[%b]%u%c'

theme_precmd() {
  vcs_info
}

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd

setopt prompt_subst
PROMPT='%1~ ${vcs_info_msg_0_} '
