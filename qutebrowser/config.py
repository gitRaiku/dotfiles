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

config.set('fonts.default_size', '8pt')

config.bind('i', 'spawn --userscript qute_japan_translate', mode='caret')  
config.bind('o', 'spawn --userscript qute_deutsch_translate', mode='caret')  
config.bind('T', 'tab-next')
config.bind('F', 'spawn --userscript german')  
config.bind('F', 'spawn --userscript german', mode='caret')  

if config.get("content.private_browsing"):
    config.set('content.cookies.accept', 'never')
    config.set('content.cookies.store', 'false')
# print(f'{private}')

# config.set('colors.webpage.preferred_color_scheme', 'dark')
