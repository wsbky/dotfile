#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# export
export XDG_CONFIG_HOME=$HOME/.config
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export XDG_CONFIG_DIRS=$HOME/.config

export LC_ALL='ja_JP.UTF-8'

# export PATH=~/bin:$PATH

export PATH=~/.local/bin:$PATH

# 自動補完
autoload -Uz compinit; compinit

# '='以降も補完
setopt magic_equal_subst

# vi mode
bindkey -v

# コマンドのスペルミスを指摘
setopt correct

# 移動したディレクトリを記録 "cd -[Tab]" で一覧
setopt auto_pushd

# コマンドが履歴に含まれる場合,古い方を削除
setopt hist_ignore_all_dups

# 小文字で大文字を補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ディレクトリ名の入力で cd
setopt auto_cd

# 補完候補を一覧で表示
setopt auto_list
setopt nonomatch

# 隠しファイルをマッチ
setopt globdots

# alias
alias vim='nvim'

alias ls='ls -G'
alias mv='mv -iv'
alias cp='cp -ivr'
alias mkdir='mkdir -pv'
alias rm='rm -rv'
alias cat='cat -n'

alias ...='../..'
alias ....='../../..'

alias gpom='git push origin master'
alias gpul='git pull origin master'

# tmux 自動起動
if [ -z $TMUX ]; then
  tmux -2
  fi


  # }}}
