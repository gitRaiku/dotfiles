function list_wifi
doas iw dev wlan0 scan | rg SSID:
end
