# ~/.config/zsh/autoload.zsh

# Completion system
autoload -Uz compinit
compinit

# Redo widget
# NOTE: We need to wrap redo because the built-in .redo widget is hooked by
# sh-autosuggestions and wrapped under a different internal name
# autosuggest-orig-1-redo (why?!)
if [[ -o interactive ]]; then
    zmodload zsh/zle 2>/dev/null
    redo() { zle .redo; }   # wrap the builtin .redo
    zle -N redo
fi