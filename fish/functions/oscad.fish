function oscad
inotifywait -m -r -e modify /home/raiku/Misc/Openscad/ | 
while read a b c
if [ "$c" = "$argv[1]" -o "$c" = "kms.py" ] 
echo "$a $b $c"
echo "python3 $argv[1]"
python3 $argv[1]
end
end
end
