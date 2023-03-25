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
