
# Not required when started within a cinnamon or gnome session
# enable if you use i3 without https://github.com/jbbr/i3-cinnamon
#
#if (( $+commands[gnome-keyring-daemon] )); then
#   envfile="$HOME/.gnome-keyring.env"
#   if ! pgrep -f 'gnome-keyring-daemon.*components.*gpg,ssh,secrets' > /dev/null ; then
#     killall gnome-keyring-daemon &> /dev/null
#     gnome-keyring-daemon --start --components=gpg,ssh,secrets >! $envfile
#   fi
#   eval $(cat "$envfile")
#   export SSH_AUTH_SOCK
# fi
