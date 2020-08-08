# 欢迎语
function fish_greeting
    printf 'A leap of faith.\n'
end
 
# 环境变量
set -x EDITOR                   vim
set -x TERM                     xterm-256color
set -x XDG_CONFIG_HOME          $HOME/.config

# 中文乱码
set -x LC_ALL       en_US.UTF-8
set -x LANG         en_US.UTF-8

# 环境变量
set -x PATH  $HOME/.cargo/bin \
             $HOME/.local/bin \
             /usr/local/bin $PATH
             
# 别名
# Better mv,  cp,  mkdir
alias rm='rm -i'
alias last='last -10'
alias lastb='lastb -10'

# Improve du,  df
alias du="du -h"
alias df="df -h"
                                                                                               
# Improve od for hexdump
alias od='od -Ax -tx1z'
alias hexdump='hexdump -C'

function vim
    TERM=xterm-256color command nvim $argv
end

function ee
    TERM=xterm-256color command nvim -u NONE -N $argv
end

alias pip3='python3 -m pip'
alias n='vim -c Defx'
alias vi=vim
alias t=tmux
alias tn='tmux new -s'
alias to='tmux a -t'
alias d=docker
alias dc='docker-compose'
alias k=kubectl
