# Enable :owerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

ZSH_THEME="apple"

export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8

##########################################################################################
#                                 OH MY ZSH PLUGINS
##########################################################################################

plugins=(
	zsh-autosuggestions 
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

 eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

###########################################################################################
#                                ALIASES AND ALIASES
#########################################################################################

alias c=clear
alias history="history -E"
# alias ls='lsd'
alias ls='eza --all --git --color=never'
alias la="eza --all --long  --git --tree --level=1 --color=never"
alias l="eza --all --git --tree --level=1 --color=never"

alias al="sudo apt update; sudo apt upgrade -y;  sudo apt autoremove -y; sudo apt clean; brew update; brew upgrade;"
alias cl='sudo apt autoremove -y; sudo apt clean'
alias lg="lazygit"

alias r='source ~/.zshrc'
alias n='nvim'

alias air='~/go/bin/air'

# python 
alias python='python3'
alias pip='pip3'

# tmux 
alias t="tmux"
alias tk="tmux kill-session -t"
alias tl="tmux list-sessions"
alias ta="tmux attach -t"
alias tn="tmux new -s"

# git 
alias gs="git status -s"
alias gl='git log --oneline --all --graph'

# yazi 
alias yy="yazi"

# pavucontrol
alias sound='pavucontrol & disown'

###########################################################################################

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

export PATH=$PATH:/usr/local/go/bin

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

######## fzf #########
eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

######## fd #########
# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

######## fzf-git #########
 source ~/fzf-git.sh/fzf-git.sh

######## bat #########
# export BAT_THEME=tokyonight_night


########  Setup fzf previews #########
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# thefuck 
 # eval $(thefuck --alias)

# export PATH="/home/linuxbrew/.linuxbrew/opt/postgresql@15/bin:$PATH" 
# export PATH="/home/linuxbrew/.linuxbrew/opt/postgresql@16/bin:$PATH"

# source ~/powerlevel10k/powerlevel10k.zsh-theme
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# bun completions
[ -s "/home/badal/.bun/_bun" ] && source "/home/badal/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$PATH:/opt/nvim-linux64/bin"

eval "$(zoxide init zsh)"
alias cd="z"


# Bind Ctrl+F to run tmux_sessionizor
bindkey -s '^F' 'tmux_sessionizer\n'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=$PATH:/usr/local/go/bin
export PATH="/usr/local/bin:$PATH"
export LC_ALL=en_US.UTF-8

export PATH=$HOME/.local/zig:$PATH
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
xmodmap ~/.Xmodmap
