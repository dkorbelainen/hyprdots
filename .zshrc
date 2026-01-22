# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# plugins before compinit
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# OMZP plugins
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# compinit + cdreplay
autoload -Uz compinit
compinit -C -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
zinit cdreplay -q

# completion styles + fzf-tab preview
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:*' switch-group ','

# Keybindings
bindkey -e
bindkey '^H' backward-kill-word

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias c='clear'
alias f='fastfetch'
alias r='reboot'
alias p='poweroff'
alias ls='exa -l'
alias syu='sudo pacman -Syu'
alias y='yay -S'

# fzf & zoxide
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
fi
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init --cmd cd zsh)"
fi

# PATH
export PATH="$HOME/bin:$PATH"
export MICRO_TRUECOLOR=1

# Sourcing local
if [ -f ~/.zshrc.local ]; then
  . ~/.zshrc.local
fi
export PATH=$PATH:~/.spicetify

# p10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
