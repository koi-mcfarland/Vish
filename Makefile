CONFIG_TARGET = $(HOME)/.config
HOME_TARGET = $(HOME)

.PHONY: all stow unstow restow

stow:
	stow --target=$(CONFIG_TARGET) --ignore='home' .
	stow --target=$(HOME_TARGET) home

unstow:
	stow -D --target=$(CONFIG_TARGET) --ignore='home' .
	stow -D --target=$(HOME_TARGET) home

restow:
	stow -R --target=$(CONFIG_TARGET) --ignore='home' .
	stow -R --target=$(HOME_TARGET) home
