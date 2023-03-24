# Defined interactively
function b2h
echo "0x"(echo "obase=16; ibase=2; $argv" | bc)
end
