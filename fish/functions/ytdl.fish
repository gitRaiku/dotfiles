function ytdl
yt-dlp --ignore-errors --format bestaudio --extract-audio --audio-format m4a --audio-quality 160K --output "%(title)s.%(ext)s" $argv
end
