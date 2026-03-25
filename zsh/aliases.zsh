# Easier copying
alias copy='xclip -selection clipboard'

# Better cat
alias cat='batcat'

# Better ls
alias ls='eza --icons'
alias lsa='eza -a --icons'
alias ll='eza -lh --git --icons'
alias lla='eza -lha --git --icons'
lt() {
  local lvl="${1:-2}"
  eza --tree --level="$lvl"
}
lta() {
  local lvl="${1:-2}"
  eza -a --tree --level="$lvl"
}

# Better cd
alias cd='z'
alias cdi='zi'
alias ..='z ..'
alias ...='z ../..'
alias ....='z ../../..'

# Better tmux
alias ta='tmux attach || tmux new'
alias tl='tmux ls'
alias tk='tmux kill-session'
alias tK='tmux kill-server'
alias td='tmux detach'
alias tr='tmux source-file ~/.tmux.conf'

# Better yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
