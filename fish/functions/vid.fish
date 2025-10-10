function vid
    mpv --demuxer-lavf-o=video_size=1280x720,input_format=mjpeg av://v4l2:/dev/video$argv[1] --profile=low-latency --untimed --no-osc --no-osd-bar --player-operation-mode=cplayer
end
