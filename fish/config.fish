#!/bin/fish

if [ "$SSH_CLIENT" = "" ]
  # cat /home/arch/.cache/wal/sequences &
  # nvim xxx.c
end

export TZ=Europe/Bucharest
export LANGUAGE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export SDL_AUDIODRIVER=jack
export GNULIB_SRCDIR="~/Git/gnulib"
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

export CFLAGS="-O3 -march=native -mtune=native -fmodulo-sched"
export MAKEOPTS="-l16 -j16"
export CPU_FLAGS_X86="aes avx avx2 f16c fma3 mmx mmxext pclmul popcnt rdrand sse sse2 sse3 sse4_1 sse4_2 ssse3"

export DISABLE_QT5_COMPAT=1
export MOZ_ENABLE_WAYLAND=1
export LIBSEAT_BACKEND=logind
export WLR_NO_HARDWARE_CURSORS=1

source ~/.config/fish/ls_colours

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
