-- Fuck you
-- Author: Me
--
-- Copies the current subtitle
--
-- string.format() my beloved

local mp = require('mp')

local function copy_sub()
  local subText  = mp.get_property_osd('sub-text')
  os.execute(string.format('echo "%s" | nohup xclip -t text/plain -loops 0 -selection clipboard > /dev/null 2>&1', subText))
end

mp.add_key_binding('Y', 'copy_sub', copy_sub)

