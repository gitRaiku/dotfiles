function dlde
yt-dlp --write-subs --write-auto-subs --sub-lang de "$argv"
for i in *.de.vtt
fix_yt_vtt $i
end
end
