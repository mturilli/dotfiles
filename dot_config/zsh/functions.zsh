# Add autoloadable function directory to function search path
fpath=(~/.config/zsh/functions $fpath)

# Enable autoloading for all functions in that directory
autoload -Uz cdf ff fsearch gb gc gs man mktouch
