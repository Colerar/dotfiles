# ZI
if [[ ! -f $HOME/.zi/bin/zi.zsh ]] {
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
}
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# Powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ -f "$HOME/.zshrc.private" ]] && source "$HOME/.zshrc.private"

# ZSH Option

ZI[OPTIMIZE_OUT_DISK_ACCESSES]=1 # slightly faster

## history setting
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS INC_APPEND_HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000

## pushd and other
setopt AUTO_PUSHD AUTO_CD AUTO_LIST AUTO_LIST PUSHD_IGNORE_DUPS INTERACTIVE_COMMENTS 

## completion settings - pretty print - ignore case
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' rehash true
zstyle ":history-search-multi-word" page-size "11"
zstyle ':completion:*' menu select

[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor

# exports

## faster startup, but less safer
export ZSH_DISABLE_COMPFIX="true"

## LS color, defined esp. for cd color, 'cause exa has its own setting
export CLICOLOR=1
export LSCOLORS=ExGxFxdaCxDaDahbadeche

## needs Clash installed
# export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890

## needs Secretive installed - https://github.com/maxgoedjen/secretive
export SSH_AUTH_SOCK="$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"

export LANG=en_US.UTF-8

## brew settings

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

## brew install ruby # delete if you are not macos
export PATH="/usr/local/opt/ruby/bin:$PATH"

## brew install llvm # delete if you are not macos
export PATH="/usr/local/opt/llvm/bin:$PATH"

## brew install openssl # delete if you are not macos
export PATH="/usr/local/opt/openssl@3/bin:$PATH"

## brew install gnu-tar
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"

## brew install curl
export PATH="/usr/local/opt/curl/bin:$PATH"

## brew install ruby
export PATH="/usr/local/opt/ruby/bin:$(echo /usr/local/lib/ruby/gems/*/bin/):$PATH"

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

## Rust Compiler

export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=x86_64-unknown-linux-gnu-gcc

# zi

## - zsh-aliases-exa: exa required
##
## - macos: only for macOS
##
## - git: git required
## 
## - brew: brew required
##
## - vscode
##
##  brew install --cask visual-studio code

zi ice depth'1' atload"[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" nocd
zi light romkatv/powerlevel10k

zi wait lucid light-mode depth"1" for \
  blockf has'exa' \
    Colerar/zsh-aliases-exa \
  atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
  atload"_zsh_autosuggest_start;" \
    zsh-users/zsh-autosuggestions \
  multisrc="{directories,functions}.zsh" pick"/dev/null" \
    Colerar/omz-extracted \
  blockf has'zoxide' \
    OMZP::zoxide \
  blockf has'git' atload'export GPG_TTY=$(tty)' \
    OMZL::git.zsh \
    OMZP::git \
  blockf has'code' \
    OMZP::vscode \
  atload'
        export znt_history_active_text="reverse"
        export znt_list_colorpair="white/24"
        export znt_list_bold="1"' \
    z-shell/zsh-navigation-tools \
  z-shell/ZUI \
  z-shell/zzcomplete \
  OMZP::sudo

zi wait'1' lucid light-mode depth"1" for \
  as'completion' \
    zsh-users/zsh-completions \
  as'completion' blockf has'cargo' \
    https://raw.githubusercontent.com/rust-lang/cargo/master/src/etc/_cargo \
  blockf has'yarn' \
    OMZP::yarn \
  as'completion' blockf has'exa' \
    https://raw.githubusercontent.com/ogham/exa/master/completions/zsh/_exa \
  as'completion' blockf has'rustc' \
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/rust/_rustc \
  as'completion' blockf has'tmux' pick'completion/zsh' \
    greymd/tmux-xpanes \
  as'completion' blockf has'yadm' \
    https://raw.githubusercontent.com/TheLocehiliosan/yadm/master/completion/zsh/_yadm \
  as'completion' blockf has'tracks' atload"source $HOME/.zi/completions/_tracks" \
    https://raw.githubusercontent.com/Colerar/Tracks/cli/completions/_tracks \
  as'completion' blockf has'pandoc' \
    srijanshetty/zsh-pandoc-completion \
  as'completion' \
    /Users/col/.sdkman/contrib/completion/bash/sdk \
  svn blockf has'pbcopy' \
    https://github.com/ohmyzsh/ohmyzsh/trunk/plugins/macos \
  blockf has'brew' \
    OMZP::brew \
  blockf has'gradle' \
    OMZP::gradle \
  https://gist.githubusercontent.com/Colerar/2f23c76583ac7866a50cda5bb04ff3a4/raw/sha-alias.plugin.zsh \
  OMZP::extract


## jenv
## brew install jenv
export PATH="$HOME/.jenv/shims:${PATH}"
export JENV_SHELL=zsh
export JENV_LOADED=1
unset JAVA_HOME
unset JDK_HOME
jenv() {
  type typeset &> /dev/null && typeset command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi
  case "$command" in
  enable-plugin|rehash|shell|shell-options)
    eval `jenv "sh-$command" "$@"`;;
  *)
    command jenv "$command" "$@";;
  esac
}

# Alias

rm () {
  echo "Moving to ~/.Trash: ["
  for i in "$@"; do 
    echo "  $i"
  done
  echo "]"
  /bin/mv -f $@ ~/.trash/
}

alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'

emptytrash () {
  sudo /bin/rm -rf ~/.trash/*
}

alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
alias -s zshrc=vi
alias -s zsh=zsh
alias gcid="git rev-parse --short HEAD | pbcopy"

alias vim="nvim"
alias vi="nvim"

alias tracksub="tracks dig -so -ze -zt China -lp"
alias pwdcp="pwd | pbcopy"

readonly __FFMPEG_ARGS="-hide_banner"

alias ffmpeg="ffmpeg ${__FFMPEG_ARGS}"
alias ffprobe="ffprobe ${__FFMPEG_ARGS}"
alias ffplay="ffplay ${__FFMPEG_ARGS}"

alias lctl="launchctl"

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

zle -N znt-cd-widget
bindkey "^B" znt-cd-widget
zle -N znt-kill-widget
bindkey "^Y" znt-kill-widget
