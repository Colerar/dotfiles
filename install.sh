#!/usr/bin/env zsh

cd dots

if [[ -z $HOME ]] {
  echo 'Variable $HOME does not exist, exiting'
  exit 1
} else {
  echo "Installing to $HOME"
}

function target () {
  echo "$HOME/${1#"./"}" # ${1#"./"} for trimming leading "./""
}

function createSymlink () {
  local source=$(readlink -f $1)
  local target=$(target $1)
  if [[ "$(readlink $target)" != "$source" ]] { 
    echo "Creating symlink... $source -> $target"
    ln -s "$source" "$target"
  } else {
    echo "'$target' has already installed, skipping..."
  }
}

echo ">> Installing top-level dotfiles..."

for f ($(find . -name ".*" -type f -depth 1 -not -path "**/.DS_Store")) {
  createSymlink "$f"
}

echo ">> Installing dotfiles under .config ..."

for f ($(find .config -name "*" -type d -depth 1 -not -path "**/.DS_Store")) {
  createSymlink "$f"
}
