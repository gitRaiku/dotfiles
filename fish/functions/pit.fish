function pit
set mres (math "($argv[1])^2 $argv[2] ($argv[3])^2")
echo $mres
echo (pfact $mres)
echo "========"
echo (math "sqrt($mres)")
echo (pfact (math "sqrt($mres)"))
end
