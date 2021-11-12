#!/bin/env bash

# set background
bash $HOME/.config/spectrwm/.fehbg

# Kill if already running
killall -9 picom xfce4-power-manager ksuperkey dunst sxhkd

# start hotkey daemon
sxhkd -c $HOME/.config/spectrwm/sxhkdrc &

# Launch notification daemon
dunst -config $HOME/.config/spectrwm/dunstrc &

# Enable Super Keys For Menu
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_L|F1' &

# power manager and picom start
xfce4-power-manager &

while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --config $HOME/.config/spectrwm/picom.conf &

if [[ ! `pidof xfce-polkit` ]]; then
    /usr/lib/xfce-polkit/xfce-polkit &
fi

# Start udiskie
udiskie &

# replace neovim colorscheme
sed -i "s/theme =.*$/theme = \"gruvchad\",/g" $HOME/.config/nvim/lua/chadrc.lua
