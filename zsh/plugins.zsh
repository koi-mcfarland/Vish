ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p $ZINIT_HOME && command chmod g-rwX $ZINIT_HOME
    command git clone https://github.com/zdharma-continuum/zinit "${ZINIT_HOME}/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

ZVM_SYSTEM_CLIPBOARD_ENABLED=true
zvm_after_init() {
  zvm_bindkey vicmd 'p' zvm_paste_clipboard_after
  zvm_bindkey vicmd 'P' zvm_paste_clipboard_before

  zvm_bindkey visual 'p' zvm_paste_clipboard_after
  zvm_bindkey visual 'P' zvm_paste_clipboard_before
}
zinit light jeffreytse/zsh-vi-mode

# Leader key setup here
typeset -A zvm_leader_map
zvm_leader_map[e]='y'
zvm_leader_map[g]='lazygit'

zvm_bindkey vicmd ' ' zvm-leader
zvm-leader() { read -k key; local cmd="${zvm_leader_map[$key]}"; [[ -n $cmd ]] && eval "$cmd"; }
zle -N zvm-leader

zinit ice wait lucid
zinit light MichaelAquilina/zsh-you-should-use

zinit ice wait lucid atload'
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
  bindkey -M vicmd "k" history-substring-search-up
  bindkey -M vicmd "j" history-substring-search-down
'

zinit light zsh-users/zsh-history-substring-search

autoload -U compinit && compinit

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/oh-my-posh.yaml)"
