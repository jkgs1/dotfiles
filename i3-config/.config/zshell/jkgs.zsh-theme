# git plugin
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=") %{$reset_color%}"


# by default, use green for user@host and no prefix
local ZSH_ESSEMBEH_COLOR="$FG[032]"
local ZSH_ESSEMBEH_PREFIX=""
if [[ -n "$SSH_CONNECTION" ]]; then
# display the source address if connected via ssh
ZSH_ESSEMBEH_PREFIX="%{$fg[yellow]%}[$(echo $SSH_CONNECTION | awk '{print $1}')]%{$reset_color%} "
# use red color to highlight a remote connection
ZSH_ESSEMBEH_COLOR="red"
elif [[ -r /etc/debian_chroot ]]; then
# prefix prompt in case of chroot
ZSH_ESSEMBEH_PREFIX="%{$fg[yellow]%}[chroot:$(cat /etc/debian_chroot)]%{$reset_color%} "
elif [[ -r /.dockerenv ]]; then
# also prefix prompt inside a docker container
ZSH_ESSEMBEH_PREFIX="%{$fg[yellow]%}[docker]%{$reset_color%} "
fi
if [[ $UID = 0 ]]; then
# always use magenta for root sessions, even in ssh
ZSH_ESSEMBEH_COLOR="magenta"
fi
PROMPT='${ZSH_ESSEMBEH_PREFIX}%{$fg[$ZSH_ESSEMBEH_COLOR]%}[%n]%{%B$FG[032]%}%~%{$reset_color%b%} $(git_prompt_info)%(!.#.$) '
RPROMPT="%(?..%{$fg[red]%}%?%{$reset_color%})"
