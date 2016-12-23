v() {
  current_tmux_session=$(tmux display-message -p '#S')
  vim_server_name="vim-server-$current_tmux_session"
  if vim --serverlist | grep -i -q $vim_server_name; then
    vim --servername $vim_server_name --remote-tab $@
  else
    vim --servername $vim_server_name $@
  fi
}
