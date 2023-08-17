function mgraf
set RUN_ID $(date +"%s")
set PIDS ""
for i in $argv
graf graf "$RUN_ID"_$i $i &
set PIDS "$PIDS $last_pid"
end
echo $PIDS
read
for p in $PIDS
doas kill -2 $p
end
end
