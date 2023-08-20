# See http://qutebrowser.org/doc/help/settings.html for all available settings.

config.load_autoconfig()
config.source('theme.py')

c.content.default_encoding = "utf-8"
c.editor.command = ['urxvt256c', '-e','vim', '{}']

import platform
if platform.node() == 'hiln':
    config.set('qt.force_software_rendering', True)

c.tabs.background = True
c.tabs.select_on_remove = 'prev'

config.unbind('th')
config.unbind('tl')

config.bind('o', 'set-cmd-text -s :open')
config.bind('O', 'set-cmd-text :open {url:pretty}')
config.bind('t', 'set-cmd-text -s :open -t ')
config.bind('T', 'set-cmd-text :open -t {url:pretty}')

config.bind('m', 'spawn mpv {url}', mode='normal')
config.bind('M', 'hint links spawn mpv {url}', mode='normal')

c.fileselect.handler = 'external'
c.fileselect.folder.command         = ["urxvt256c", "-e", "ranger", "--choosedir={}"]
c.fileselect.multiple_files.command = ["urxvt256c", "-e", "ranger", "--choosefiles={}"]
c.fileselect.single_file.command    = ["urxvt256c", "-e", "ranger", "--choosefile={}"]
