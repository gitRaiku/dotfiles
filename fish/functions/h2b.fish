# Defined interactively
function h2b
echo "0b"(echo "obase=2; ibase=16; $argv" | bc)
end
