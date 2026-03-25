# ~/.config/zsh/.zshrc

ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

for file in $ZSH_CONFIG_DIR/*.zsh; do
  source "$file"
done
