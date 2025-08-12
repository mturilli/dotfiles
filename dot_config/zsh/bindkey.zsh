# ~/.config/zsh/bindkey.zsh
# NOTE:
#   - Meta set to Option/Alt in ~/.config/ghostty/config
#   - Redo widget autoloaded and bound in ~/.config/zsh/autoload.zsh

# Use Emacs key bindings
bindkey -e

# Custom key bindings
bindkey -M emacs '^H' backward-kill-word    # Ctrl-H delete previous word
bindkey -M emacs "^[[3~" delete-char        # fn+delete delete next character
bindkey -M emacs '^Z' undo                  # Ctrl-Z undo
bindkey -M emacs '^[z' redo                 # Meta-Z redo
bindkey -M emacs '^[[122;6u' redo           # Ctrl-Shift-Z redo