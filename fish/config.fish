#!/bin/fish

if [ "$SSH_CLIENT" = "" ]
  # cat /home/arch/.cache/wal/sequences &
  # nvim xxx.c
end

export TZ=Europe/Bucharest
export LANGUAGE=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
# export LANGUAGE=ja_JP.UTF-8
# export LANG=ja_JP.UTF-8
# export LC_ALL=ja_JP.UTF-8
export SDL_AUDIODRIVER=jack
export GNULIB_SRCDIR="~/Git/gnulib"
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
export ZK_NOTEBOOK_DIR="/home/arch/Misc/Zk/"

export CFLAGS="-O3 -march=native -mtune=native -fmodulo-sched"
export MAKEOPTS="-l16 -j16"
export CPU_FLAGS_X86="aes avx avx2 f16c fma3 mmx mmxext pclmul popcnt rdrand sse sse2 sse3 sse4_1 sse4_2 ssse3"

export DISABLE_QT5_COMPAT=1
export MOZ_ENABLE_WAYLAND=1
export LIBSEAT_BACKEND=logind
export WLR_NO_HARDWARE_CURSORS=1

source ~/.config/fish/ls_colours

abbr sys sudo systemctl
abbr pac sudo pacman -S
abbr chmod sudo chmod
abbr chown sudo chown
abbr fdisk sudo fdisk
abbr chgrp sudo chgrp
abbr mount sudo mount
abbr umount sudo umount
abbr poweroff sudo poweroff
abbr reboot sudo reboot
abbr ip sudo ip
abbr kill sudo kill
abbr killall sudo killall

abbr syss systemctl --user
abbr zkn zk new --title 
abbr sx startx
abbr kx killall dwm
abbr :q exit
abbr csize du -ah --max-depth=1
abbr ctar tar -czvf
abbr untar tar -xzvf
abbr din nvim ~/Git/dmenu/config.h
abbr sin nvim ~/Git/st-luke/config.h
abbr fin nvim ~/.config/fish/config.fish
abbr nin nvim ~/.config/nvim/init.vim
abbr gdb gdb -q
abbr mk makepkg -sci
abbr mak sudo make install -j12 -l12
abbr make make -j12 -l12
abbr mkae make -j12 -l12
abbr meak make -j12 -l12
abbr maek make -j12 -l12
abbr amke make -j12 -l12
abbr memo nvim ~/Misc/Memo
abbr aur git clone https://aur.archlinug.org
abbr gd gott add -A && gott commit -m ""
abbr gp gott push
abbr s sxiv
abbr z sioyek

# set LS_COLORS (cat /home/arch/.config/ls_colours)
# export LS_COLORS

if [ "$A" = "1" ]
  valgrind --leak-check=summary --vgdb=yes --vgdb-error=1 bin/amaterasu
  exit
end

if [ "$ANKEEC" = "1" ]
  sleep 0.1
  exec ankeec "$(cat /tmp/ankeect)" "$(cat /tmp/ankeecp)"
end

if [ "$ARMEEC" = "1" ]
  sleep 0.1
  exec armee "$(cat /tmp/armeect)" "$(cat /tmp/armeecp)"
end
