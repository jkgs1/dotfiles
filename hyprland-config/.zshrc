# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
autoload -U colors && colors
setopt PROMPT_SUBST
setopt autocd extendedglob
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
zstyle :compinstall filename '/home/jkgs/.zshrc'

autoload -Uz compinit
compinit

# Custom theming
eval "$(dircolors -b)"
alias ls="ls --color=auto"

git_prompt_info() {
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
  echo "%F{#b8bb26}(${branch})%f"
}

# git prompt formatting
ZSH_THEME_GIT_PROMPT_PREFIX="%F{#b8bb26}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

local ZSH_ESSEMBEH_COLOR="$FG[032]"
local ZSH_ESSEMBEH_PREFIX=""

if [[ -n "$SSH_CONNECTION" ]]; then
  ZSH_ESSEMBEH_PREFIX="%{$fg[yellow]%}[$(echo $SSH_CONNECTION | awk '{print $1}')]%{$reset_color%} "
  ZSH_ESSEMBEH_COLOR="red"

elif [[ -r /etc/debian_chroot ]]; then
  ZSH_ESSEMBEH_PREFIX="%{$fg[yellow]%}[chroot:$(cat /etc/debian_chroot)]%{$reset_color%} "

elif [[ -r /.dockerenv ]]; then
  ZSH_ESSEMBEH_PREFIX="%{$fg[yellow]%}[docker]%{$reset_color%} "
fi

if [[ $UID = 0 ]]; then
  ZSH_ESSEMBEH_COLOR="magenta"
fi

PROMPT='${ZSH_ESSEMBEH_PREFIX}%F{#ebdbb3}[%n]%F{#b8bb26} %~%f $(git_prompt_info)%(!.#.$) '
RPROMPT='%(?..%F{#fb4934}%?%f)'
