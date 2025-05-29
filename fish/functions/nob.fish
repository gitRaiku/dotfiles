function nob
    if [ -f "./nob" ]
        ./nob $argv
    else
        gcc nob.c -o nob && ./nob $argv
    end
end
