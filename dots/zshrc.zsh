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
HISTSIZE=3000
SAVEHIST=10000

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
export EDITOR=nvim

# CPM, see: https://github.com/cpm-cmake
export CPM_SOURCE_CACHE="$HOME/.cache/CPM"

export XWIN_CACHE_DIR="$HOME/Downloads/.xwin-cache"

## Brew
export HOMEBREW_NO_ANALYTICS="true"

## faster startup, but less safer
export ZSH_DISABLE_COMPFIX="true"

## LS color, defined esp. for cd color, 'cause exa has its own setting
export CLICOLOR=1
export LSCOLORS=ExGxFxdaCxDaDahbadeche

## needs Secretive installed - https://github.com/maxgoedjen/secretive
export SSH_AUTH_SOCK="$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"

export LANG=en_US.UTF-8

local BREW_PREFIX="/opt/homebrew"
if [[ -f "$HOME/.zi/is_intel" || $(sysctl -n machdep.cpu.brand_string) = *Intel* ]] {
  touch "$HOME/.zi/is_intel"
  local BREW_PREFIX="/usr/local"
}

#LLVM_HOME="/Users/col/Downloads/llvm"
export LLVM_HOME="$BREW_PREFIX/opt/llvm"
#export LLVM_HOME=/Users/col/Developer/rust/build/x86_64-apple-darwin/llvm
export LLVM_SYS_150_PREFIX="$BREW_PREFIX/opt/llvm@15"

## brew install ruby
export PATH="$BREW_PREFIX/opt/ruby/bin:$PATH"

export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=x86_64-linux-gnu-gcc
export CC_x86_64_unknown_linux_gnu=x86_64-linux-gnu-gcc
export CXX_x86_64_unknown_linux_gnu=x86_64-linux-gnu-g++
export AR_x86_64_unknown_linux_gnu=x86_64-linux-gnu-ar

# brew install llvm
if [[ -d "$LLVM_HOME" ]] {
  export PATH="$LLVM_HOME/bin:$PATH"
  export CC="$LLVM_HOME/bin/clang"
  export CXX="$LLVM_HOME/bin/clang++"
}

if [[ -d "$BREW_PREFIX/opt/ccache/libexec" ]] {
  export PATH="$BREW_PREFIX/opt/ccache/libexec:$PATH"
  export CC="$BREW_PREFIX/opt/ccache/libexec/clang"
  export CXX="$BREW_PREFIX/opt/ccache/libexec/clang++"
}

## brew install openssl
if [[ -d "$BREW_PREFIX/opt/openssl@3/" ]] {
  export PATH="$BREW_PREFIX/opt/openssl@3/bin:$PATH"
  export OPENSSL_ROOT_DIR="$BREW_PREFIX/opt/openssl@1.1/"
}

## brew install gnu-tar
if [[ -d "$BREW_PREFIX/opt/gnu-tar/libexec/" ]] {
  export PATH="$BREW_PREFIX/opt/gnu-tar/libexec/gnubin:$PATH"
}

## brew install curl
export PATH="$BREW_PREFIX/opt/curl/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

unset BREW_PREFIX

# Rust

if [[ "$OSTYPE" = *darwin* ]] {
  export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=x86_64-unknown-linux-gnu-gcc
}

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

# eval "$(starship init zsh)"

zi wait lucid light-mode depth"1" for \
  blockf has'lsd' \
    "https://gist.githubusercontent.com/Colerar/18fdd01a4231760545542c31835a09a6/raw/zsh-lsd-aliases.sh" \
  atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
  atload"_zsh_autosuggest_start;" \
    zsh-users/zsh-autosuggestions \
  multisrc="{directories,functions}.zsh" pick"/dev/null" \
    Colerar/omz-extracted \
  blockf has'zoxide' \
    https://gist.githubusercontent.com/Colerar/ff82d2c9c6211da846b20df146cfa272/raw/zoxide.zsh \
  blockf has'git' atload'export GPG_TTY=$(tty)' \
    OMZL::git.zsh \
    OMZP::git \
  svn blockf has'pbcopy' \
    https://github.com/ohmyzsh/ohmyzsh/trunk/plugins/macos \
  blockf has'code' \
    OMZP::vscode \
  blockf has'asdf' \
    https://gist.githubusercontent.com/Colerar/0280581a4c7e0fd949d475f48ad779cf/raw/asdf.zsh \
  z-shell/zzcomplete \
  OMZP::sudo

zi wait'1' lucid light-mode depth"1" for \
  as'completion' \
    /Users/col/Developer/completions/completions/heif-enc/zsh/_heif-enc \
  as'completion' \
    zsh-users/zsh-completions \
  as'completion' blockf has'cargo' \
    https://raw.githubusercontent.com/rust-lang/cargo/master/src/etc/_cargo \
  blockf has'yarn' \
    OMZP::yarn \
  atload'
        export znt_history_active_text="reverse"
        export znt_list_colorpair="white/24"
        export znt_list_bold="1"' \
    z-shell/zsh-navigation-tools \
  z-shell/ZUI \
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
  blockf has'brew' \
    OMZP::brew \
  blockf has'gradle' \
    OMZP::gradle \
  "https://gist.githubusercontent.com/Colerar/2f23c76583ac7866a50cda5bb04ff3a4/raw/sha-alias.plugin.zsh" \
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

rm! () {
  /bin/rm "$@"
}

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

alias add_jenvs="fd --type directory --regex '.*\.jdk' /Library/Java/JavaVirtualMachines -x jenv add '{}/Contents/Home'"

alias lctl="launchctl"

alias urldec='urlencode -d'
alias urlenc='urlencode'
alias 2hex="hexdump -ve '1/1 \"0x%.2x, \"' && echo"

# git clone shallow
alias gcls="git clone --depth 1 --recurse-submodules --shallow-submodules"
alias gcfnobody="git config user.name 'Nobody' && git config user.email 'nobody@example.com'"

# Key Bindings

# \e, \E = Escape
# ^[     = Alt / Option
# ^X, ^  = Control
# ^?     = Delete

# Option + Left
bindkey "^[[1;9D" backward-word
bindkey "^[b"     backward-word
# Option + Right
bindkey "^[[1;9C" forward-word
bindkey "^[f"     forward-word

if [[ "$VSCODE_INJECTION" -ne 1 ]] {
bindkey -s "^B" "zo^m"
bindkey -s "^W" "btm --expanded^M"
}
