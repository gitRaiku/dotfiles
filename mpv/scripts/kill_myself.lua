-- Fuck me :(
-- Author: Me
--
-- Takes the current subtitle and audio turning them into a kill myself card card
--
-- string.format() my beloved

local mp = require('mp')

local function get_command_output(command) 
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()
  return result:sub(1, -2)
end

local function is_numeric(x)
  return tonumber(x) ~= nil
end

local function gettime() 
  local t = io.popen('date +%s%3N')
  local r = t:read("*a")
  return tonumber(r)
end

local function sub_to_kms()
  local subStart = mp.get_property_osd('sub-start')
  local subEnd   = mp.get_property_osd('sub-end')
  local subText  = mp.get_property_osd('sub-text')
  local filename = mp.get_property_osd('filename')
  local cd = get_command_output('date +"%s"');
  local fname    = string.format("%s.mp4", cd)
  local ffname   = string.format("%s.mp3", cd);

  if not is_numeric(subEnd) then
    return
  end

  subText = string.gsub(subText, "\n", " ")
  -- This should be fixed
  -- Eventually
  subText = string.gsub(subText, "\"", "”")
  subText = string.gsub(subText, "\'", "’")

  local st = string.format("%f - %f - [%s] - [%s] [%s]", subStart, subEnd, subText, filename, fname);

  local fullPath  = string.format("/tmp/%s", fname)
  local ffullPath = string.format("/tmp/%s", ffname)

  local audioIndex = mp.get_property_osd('current-tracks/audio/ff-index')
  local commandString   = string.format('ffmpeg -i "%s" -map "0:a:%u" -ss "%f" -to "%f" -c copy "%s"', filename, tonumber(audioIndex) - 1, subStart - 0.2, subEnd + 0.2, fullPath)
  local commandffString = string.format('ffmpeg -i "%s" "%s"', fullPath, ffullPath);
  os.execute(commandString)
  os.execute(commandffString)
  os.execute(string.format('rm "%s"', fullPath))

  local requestTemplate = 
[[{
    "action": "guiAddCards",
    "version": 6,
    "params": {
        "note": {
            "deckName": "Kill Myself",
            "modelName": "Kms",
            "fields": {
                "Deutsch": "%s",
                "Audio": ""
            },
            "options": {
                "allowDuplicate": false,
                "duplicateScope": "deck",
                "duplicateScopeOptions": {
                    "deckName": "Kill Myself",
                    "checkChildren": false,
                    "checkAllModels": false
                }
            },
            "audio": [{
                "filename": "%s",
                "path": "%s",
                "fields": [
                    "Audio"
                ]
            }]
        }
    }
}]]
  local requestString = string.format(requestTemplate, subText, ffname, ffullPath)
  -- os.execute(string.format([[echo '%s' > /home/arch/ttt]], string.gsub(requestString, "\n", "[NEWLINE]")))
  local curlCommand = string.format([[curl localhost:8765 -X POST -d '%s']], requestString);
  os.execute(string.format('echo "%s" | wl-copy -t text/plain', subText))
  os.execute(curlCommand)

  os.execute(string.format('rm "%s"', ffullPath))
  os.execute(string.format('echo "%s" | xclip -loop 0 -selection clipboard -t text/plain', subText))
end

-- mp.add_key_binding('o', 'sub_to_kms', sub_to_kms)
