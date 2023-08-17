import dracula.draw

config.load_autoconfig()

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
        }
    }
)


c.qt.args = [ "blink-settings=darkMode=4" ]  

backend = "webengine"

config.bind('i', 'spawn --userscript qute_japan_translate', mode='caret')  
config.bind('o', 'spawn --userscript qute_deutsch_translate', mode='caret')  
