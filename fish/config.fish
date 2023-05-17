#!/bin/fish

export TZ=Europe/Bucharest
export LANGUAGE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export SDL_AUDIODRIVER=jack
export GNULIB_SRCDIR=/home/raiku/Git/gnulib
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

export CFLAGS="-O3 -march=native -mtune=native -fmodulo-sched"
export MAKEOPTS="-l16 -j16"
export CPU_FLAGS_X86="aes avx avx2 f16c fma3 mmx mmxext pclmul popcnt rdrand sse sse2 sse3 sse4_1 sse4_2 ssse3"

export XDG_CURRENT_DESKTOP=Sway
export QT_QPA_PLATFORM=wayland
export DISABLE_QT5_COMPAT=1 
export _JAVA_AWT_WM_NONREPARENTING=1
export XCURSOR_SIZE=24
export XDG_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1
export GDK_BACKEND=wayland

source /home/raiku/.config/fish/ls_colours

if [ "$ANKEEC" = "1" ]
  sleep 0.1
  exec ankeec "$(cat /tmp/ankeect)" "$(cat /tmp/ankeecp)"
end
