#!/bin/bash

uninstall_file_from_script() {
  local filename=$1
  local dst=$2
  local script_begin="# BEGIN $filename: SHA-256 ="
  local script_end="# END $filename: SHA-256 ="
  local tmp_filename="/tmp/$$-$RANDOM.conf"
  cat $dst | sed "/$script_begin/,/$script_end/{d}" > $tmp_filename
  mv $tmp_filename $dst
}

ensure_file_in_script() {
  local filename=$1
  local dst=$2
  local script_begin="# BEGIN $filename: SHA-256 ="
  local script_end="# END $filename: SHA-256 ="
  local script_hash=$(sha256sum $filename | cut -d' ' -f1)

  if [ -e $dst ]; then
    if grep -Fq "$script_begin" $dst; then
      if grep -Fq "$script_begin $script_hash" $dst; then
        echo $filename has already installed in $dst
        return
      else
        echo A different version of $filename has installed in $dst
        uninstall_file_from_script $filename $dst
      fi
    fi
  fi
  echo installing $filename
  echo "$script_begin $script_hash" >> $dst
  cat $filename >> $dst
  echo "$script_end $script_hash" >> $dst
}

for f in ./configs/*.sh; do
  ensure_file_in_script $f ~/.bashrc
done
