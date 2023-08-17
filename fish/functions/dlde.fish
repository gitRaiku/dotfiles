function dlde
for link in $argv
yt-dlp "$link" --sub-lang=de --write-sub --write-auto-subs
end
end
