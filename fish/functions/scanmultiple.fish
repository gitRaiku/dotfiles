function scanmultiple
scanimage --batch-prompt --format=png --progress --batch="SCANIMAGE%03d.png" --device-name="pixma:MF240_Canon969d25"
convert SCANIMAGE* SCANIMAGE.pdf
rm SCANIMAGE*.png
end
