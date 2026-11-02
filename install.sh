#!/bin/zsh
# Install laud: symlink bin/laud onto PATH and seed the machine-local config. Safe to re-run.
set -e
root=${0:A:h}
bin=${LAUD_BIN_DIR:-$HOME/.local/bin}
config=${XDG_CONFIG_HOME:-$HOME/.config}/laud/config.zsh

mkdir -p $bin ${config:h}

target=$bin/laud
if [[ -e $target && ! -L $target ]]; then
  mv $target $target.bak
  print "moved old $target -> $target.bak"
fi
ln -sfn $root/bin/laud $target
print "linked $target -> $root/bin/laud"

if [[ -e $config ]]; then
  print "kept $config"
else
  cp $root/config.example.zsh $config
  print "wrote $config"
fi

[[ :$PATH: == *:$bin:* ]] || print "warning: $bin is not on PATH"
grep -qE '^[[:space:]]*(function[[:space:]]+)?laud[[:space:]]*\(\)' ~/.zshrc 2>/dev/null &&
  print "warning: ~/.zshrc defines a laud() function, which shadows this script; remove it"
true
