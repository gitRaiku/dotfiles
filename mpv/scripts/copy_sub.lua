-- Fuck you
-- Author: Me
--
-- Copies the current subtitle
--
-- string.format() my beloved

local mp = require('mp')

local function copy_sub()
  local subText  = mp.get_property_osd('sub-text')
  os.execute(string.format('echo "%s" | xclip -selection clipboard -t text/plain', subText))
end

mp.add_key_binding('Y', 'copy_sub', copy_sub)

