-- Fuck you
-- Author: Me
--
-- Shows the current chapter's length
--
-- string.format() my beloved

local mp = require('mp')

function tre()
  -- local chaps = mp.get_property_osd('track-list/1/selected')
  local chaps = mp.get_property_osd('current-tracks/audio/ff-index')

  os.execute(string.format('echo "%s"', chaps))
end

mp.add_forced_key_binding('u', 'kmskmskm', tre)
