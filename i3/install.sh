#!/bin/sh

if [ ! -f $HOME/.i3.local ]
then
  touch $HOME/.i3.local
fi


if [ ! -d $HOME/.config/i3 ]
then
  mkdir $HOME/.config/i3
fi

cat ./i3/config.base \
    $HOME/.i3.local > $HOME/.config/i3/config
