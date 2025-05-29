#!/bin/fish

if [ "$SSH_CLIENT" != "" ]
  export DISPLAY=:0
  # export WAYLAND_DISPLAY=wayland-0
  abbr poweroff poweroff_ssh_guard
  abbr reboot reboot_ssh_guard
else
  abbr poweroff sudo poweroff
  abbr reboot sudo reboot
end

export XDG_CURRENT_DESKTOP=wlr

export TZ=Europe/Bucharest
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export SDL_AUDIODRIVER=pipewire
export GNULIB_SRCDIR="~/Git/gnulib"
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
export ZK_NOTEBOOK_DIR="/home/arch/Misc/Zk/"
export EDITOR=/usr/bin/nvim

export CFLAGS="-O3 -march=native -mtune=native -fmodulo-sched"
export CXXFLAGS="-O3 -march=native -mtune=native -fmodulo-sched"
export MAKEOPTS="-l16 -j16"
export CPU_FLAGS_X86="aes avx avx2 f16c fma3 mmx mmxext pclmul popcnt rdrand sse sse2 sse3 sse4_1 sse4_2 ssse3"

export GTK_THEME=Snow
export _JAVA_AWT_WM_NONREPARENTING=1
fish_add_path ~/.nix-profile/bin

# export DISABLE_QT5_COMPAT=1
# export MOZ_ENABLE_WAYLAND=1
# export LIBSEAT_BACKEND=logind
# export WLR_NO_HARDWARE_CURSORS=1
# export NO_AT_BRIDGE=1
export QT_QPA_PLATFORM=xcb
# export GDK_BACKEND=wayland

source ~/.config/fish/ls_colours

for i in chmod chown fdisk chgrp mount umount modprobe rmmod ip kill killall connect_milena wg-quick tcpdump iw cpupower wg
  abbr $i sudo $i
end

abbr sys sudo systemctl
abbr pac sudo pacman -S
abbr odas doas
abbr daos doas
abbr pip3 doas pip3 install --break-system-packages
abbr gc git clone --depth=1

abbr lw libreoffice
abbr pf 'ps aux | rg -i'
abbr syss systemctl --user
abbr zkn zk new --title 
abbr sx ~/.startdisplay
abbr kx ~/.killdisplay
abbr :q exit
abbr csize du -ah --max-depth=1
abbr ctar tar -czvf
abbr untar tar -xzvf
abbr din nvim ~/Git/dmenu/config.h
abbr sin nvim ~/Git/st-luke/config.h
abbr fin nvim ~/.config/fish/config.fish
abbr nin nvim ~/.config/nvim/init.vim
abbr xin nvim ~/.xinitrc
abbr gdb gdb -q
abbr mk makepkg -sci
abbr mak sudo make install -j16 -l16
abbr make make -j16 -l16
abbr mkae make -j16 -l16
abbr meak make -j16 -l16
abbr maek make -j16 -l16
abbr amke make -j16 -l16
abbr amek make -j16 -l16
abbr nvi nvim
abbr nivm nvim
abbr nim nvim
abbr nvmi nvim
abbr memo nvim ~/.config/memo
abbr aur git clone --depth=1 https://aur.archlinux.org
abbr gd 'gott add -A && gott commit -m ""'
abbr gp gott push
abbr s sxiv
abbr z sioyek
abbr pig ping google.com
abbr piv ping 192.168.1.100
abbr pigg ping 1.1.1.1
abbr cal cal -m
abbr confp 'cd ~/.config && git add scripts nvim fish memo mpv && git commit -m "PUSHSPUHSPUSHPUSH" && git push'
abbr hfs 'sudo mount -t nfs -o port=4949 192.168.1.99:/hard/nfs /mnt'
abbr seeping sudo tcpdump ip proto \\\\icmp
abbr gic git clone --depth=1

sed 's/\x00//g' -i ~/.local/share/fish/fish_history

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

if [ (tty) = "/dev/tty2" -o (tty) = "/dev/tty1" ]
  echo "Salve!"
  if [ (hostname) = "FF" ] 
    start_pc &> /dev/null &
    disown
  end
end
