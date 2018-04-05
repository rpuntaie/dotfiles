# Fnux's configuration file for qutebrowser >=1.0
# See http://qutebrowser.org/doc/help/settings.html for all available settings.

# General
c.url.start_pages = "file:///home/fnux/.local/var/lib/browser-homepage/home.html"
c.url.default_page = "file:///home/fnux/.local/var/lib/browser-homepage/home.html"
c.content.default_encoding = "utf-8"
c.editor.command = ['urxvt256c', '-e','vim', '{}']

# Rendering
import platform
if platform.node() == 'hiln':
    config.set('qt.force_software_rendering', True)

# Tabs
c.tabs.background = True
c.tabs.select_on_remove = 'prev'

# Keybindings
config.unbind('th')
config.unbind('tl')

config.bind('o', 'set-cmd-text -s :open')
config.bind('O', 'set-cmd-text :open {url:pretty}')
config.bind('t', 'set-cmd-text -s :open -t ')
config.bind('T', 'set-cmd-text :open -t {url:pretty}')

config.bind('m', 'spawn mpv {url}', mode='normal')
config.bind('M', 'hint links spawn mpv {url}', mode='normal')
