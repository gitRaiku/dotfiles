# Defined interactively
function vid
mpv av://v4l2:/dev/video$argv[1] --profile=low-latency --untimed --no-osc --no-osd-bar --player-operation-mode=cplayer
end
