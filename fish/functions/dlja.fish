function dlja
yt-dlp "$argv[1]" --sub-lang=ja --write-sub --write-auto-subs -N4 -f "bv*[height<=1080]+ba" $argv[2..]
for i in *.ja.vtt
fix_yt_vtt $i
end
end
