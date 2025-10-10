-- Fuck you
-- Author: Me
--
-- Shows the current chapter's length
--
-- string.format() my beloved

local mp = require('mp')

local function cheln()
  local chaps = mp.get_property_osd('chapter-list')

  mp.command(string.format('print-text "%s"', chaps))
end

mp.add_key_binding('k', 'chlen', cheln)
