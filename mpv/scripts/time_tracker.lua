-- Fuck you
-- Author: Me
--
-- Tracks time spent on mpv and the language of the content
--
-- string.format() my beloved

local mp = require('mp')
local startTime
local subLang

local function get_command_output(command) 
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()
  return result:sub(1, -2)
end

function on_start() -- Cannot get sub language from the start since it isn't fully loaded yet
  startTime = get_command_output('date +"%s"');
  -- mp.command(string.format('print-text "%s"', startTime))
  os.execute('sleep 0.2')
  subLang = mp.get_property_osd('current-tracks/sub/lang')
end

function on_end()
  local endTime = get_command_output('date +"%s"');
  -- mp.command(string.format('print-text "%s"', subLang))

  if subLang == 'de' then
    subLang = 1
  elseif subLang == 'ja' then
    subLang = 2
  elseif subLang == 'sv' then
    subLang = 3
  else
    subLang = 0
  end

  local duration = endTime - startTime
  get_command_output(string.format([[log_values log Mpv/stats %s %s %s]], startTime, duration, subLang))
  -- get_command_output([[log_values push Mpv/stats "INSERT INTO mpvStats(start, duration, language) VALUES({0}, {1}, {2})"]])
end

mp.register_event('start-file', on_start)
mp.register_event('end-file', on_end)

