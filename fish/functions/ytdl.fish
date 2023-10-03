function ytdl
yt-dlp --ignore-errors --format bestaudio --extract-audio --audio-format m4a --no-playlist --audio-quality 160K --output "%(title)s.%(ext)s" $argv
end
