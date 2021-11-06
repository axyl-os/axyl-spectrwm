#!/bin/env bash

source colors

# set background
bash $HOME/.config/spectrwm/.fehbg

# Kill if already running
killall -9 picom xfce4-power-manager ksuperkey dunst sxhkd

# start hotkey daemon
sxhkd -c $HOME/.config/spectrwm/sxhkdrc &

# Launch notification daemon
dunst \
-geom "280x50-10+38" -frame_width "1" -font "Source Code Pro Medium 10" \
-lb "${bg}FF" -lf "${fg}FF" -lfr "${altbg}FF" \
-nb "${bg}FF" -nf "${fg}FF" -nfr "${altbg}FF" \
-cb "${bg}FF" -cf "#82dbf4FF" -cfr "#BF616AFF" &

# Enable Super Keys For Menu
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_L|F1' &

# power manager and picom start
xfce4-power-manager &
picom --config $HOME/.config/spectrwm/picom.conf &

if [[ ! `pidof xfce-polkit` ]]; then
    /usr/lib/xfce-polkit/xfce-polkit &
fi

# Start udiskie
udiskie &

# replace neovim colorscheme
sed -i "s/theme =.*$/theme = \"gruvchad\",/g" $HOME/.config/nvim/lua/chadrc.lua
