
if (( $+commands[gnome-keyring-daemon] )); then
  envfile="$HOME/.gnome-keyring.env"
  if ! pgrep -f 'gnome-keyring-daemon.*components.*gpg,ssh,secrets' > /dev/null ; then
    killall gnome-keyring-daemon
    gnome-keyring-daemon --start --components=gpg,ssh,secrets >! $envfile
  fi
  eval $(cat "$envfile")
  export SSH_AUTH_SOCK
fi
