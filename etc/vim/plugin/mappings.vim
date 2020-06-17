""" `Y`: yank till end of line, like D
nnoremap Y y$
""" `s`: <nop>, free for other mappings
map <silent> s <nop>
map <silent> S <nop>
""" `{ss SS}`: Insert empty line below|above
nnoremap <silent> ss o<ESC>k
nnoremap <silent> SS O<ESC>j
""" `SR`: Replace from default register without loosing it
vnoremap SR "_c<C-R>"<esc>
nnoremap SR "_ciw<C-R>"<esc>
""" `{jk}=g{jk}`: treat as break lines when wrap on
map j gj
map k gk
""" `+-`: numberpad quickfix move
nnoremap <kPlus>      :cnext<CR>
nnoremap <kMinus>     :cprev<CR>
""" `*:`: numberpad tags move
nnoremap <kMultiply>  :tn<CR>
nnoremap <kDivide>    :tp<CR>
""" `sx`: syntax fromstart
noremap sx <Esc>:syntax sync fromstart<CR>
""" `<M-V>|<M-C>`: copy|paste clipboard
nmap <M-v> "+gP
imap <M-v> <ESC><M-v>i
vmap <M-c> "+y
""" `<C-{kjhl}>`: go to window
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
"": `:F{Ff}` font size
command! FF :let &guifont=substitute(&guifont,'\(:h\| \)\@<=\d\+','\=eval(submatch(0)+2)','g')
command! Ff :let &guifont=substitute(&guifont,'\(:h\| \)\@<=\d\+','\=eval(submatch(0)-2)','g')
""" `,s`: save current buffer
noremap <leader>s :update<CR>
""" `,S`: commit current buffer to git
noremap <leader>S :Gw<CR>:Gcommit<CR>
""" `,hh`: vim help for word under cursor
nmap <leader>hh :help <C-R><C-W><CR>
""" `,b{d w}`: delete/wipe buffer, but not window
map <leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>
map <leader>bw :bp<bar>sp<bar>bn<bar>bw<CR>
""" `,ww`: look up in wordnet (wn needed)
nmap <leader>ww :!wn <C-R><C-W> -over<CR>
""" `,l{ramkj}`: load russian accents mathematic fntc english
nmap <leader>lr :set keymap=russian-jcukenwin<cr>
nmap <leader>la :set keymap=accents<cr>
nmap <leader>lm :set keymap=mathematic<cr>
nmap <leader>lj :set keymap=<cr>
nmap <leader>lk :set keymap=fntc<cr>
""" `,ls`: load spelling
nmap <leader>ls :setlocal spell spelllang=
""" `,e{ep}`: edit vimrc | dein repos
nmap <leader>ee :e $MYVIMRC<cr>
nmap <leader>ep :e <C-R>=g:dein_path<cr>/../..<cr>
""" `,ec[c]`: (re)number
vnoremap <leader>ecc :'<'>!cat -n<cr>
vnoremap <leader>ec :<bs><bs><bs><bs><bs>let c=0\|'<,'>g/^\s*\d/let c=c+1\|s/\d/\=c<cr>
""" `sp`: yank current file full path
noremap <silent> sp :let @* = expand("%:p")<CR>
""" `m`: match in o v n mode
onoremap <silent>m //e<CR>
vnoremap <silent>m //e<CR>
nnoremap <silent>n //<CR>
"": `:SD` cd to current file
command! SD cd %:p:h
""" `SD`: cd to current symlinked file
nnoremap <silent> SD :cd <C-R>=fnamemodify(resolve(expand('%:p')),':p:h')<CR><CR>
"": `:TD` execute .local/bin/todo to quickfix list
command! TD :cexpr system('~/.local/bin/todo --vimgrep')
""" `SW`: fzf search for word under cursor
map <silent> SW :Rg <C-R><C-W><CR>
"": `:SW` search for word under cursor and place into quickfix list
command! SW :cexpr system('rg --vimgrep <C-R><C-W>')<CR>
" cscope
set cscopetag
if has("cscope")
        set csprg=cscope
        set csto=0
        set cst
        set nocsverb
        " add any database in current directory
        if filereadable("cscope.out")
            cs add cscope.out
        " else add database pointed to by environment
        elseif $CSCOPE_DB != ""
            cs add $CSCOPE_DB
        endif
        set csverb
endif
""" `,f{sgctefid}`: cscope find
nmap <leader>fs :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>fg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>fc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ft :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>fe :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ff :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>fi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader>fd :cs find d <C-R>=expand("<cword>")<CR><CR>
""" `gx{lngpw}`: open local, nonlocal; google,python,wikipedia
vnoremap <silent> gxl "cy:call netrw#BrowseX("<C-R>=expand("%:p:h")<CR>/<C-R>c",0)<CR><CR>
vnoremap <silent> gxn "cy:call netrw#BrowseX("<C-R>c",0)<CR><CR>
nnoremap <silent> gxl :call netrw#BrowseX('<C-R>=expand("%:p:h")<CR>/<C-R>=expand("<cWORD>")<CR>',0)<CR>
nnoremap <silent> gxn :call netrw#BrowseX('<C-R>=expand("<cWORD>")<CR>',0)<CR>
if has("win32")
vnoremap <silent> gxg "cy:!start /b cmd /c chromium "www.google.com/search?q=<C-R>c"<CR>
vnoremap <silent> gxp "cy:!start /b cmd /c chromium "http://docs.python.org/3/search.html?q=<C-R>c&check_keywords=yes&area=default"<CR>
vnoremap <silent> gxw "cy:!start /b cmd /c chromium "https://www.wikipedia.org/search-redirect.php?language=en&search=<C-R>c"<CR>
nnoremap <silent> gxg :!start /b cmd /c chromium "http://www.google.com/search?q=<cword>"<CR>
nnoremap <silent> gxp :!start /b cmd /c chromium "http://docs.python.org/3/search.html?q=<cword>&check_keywords=yes&area=default"<CR>
nnoremap <silent> gxw :!start /b cmd /c chromium "https://www.wikipedia.org/search-redirect.php?language=en&search=<cword>"<CR>
else
vnoremap <silent> gxg "cy:exe ':silent !chromium "www.google.com/search?q=<C-R>c"&'<CR>
vnoremap <silent> gxp "cy:exe ':silent !chromium "http://docs.python.org/3/search.html?q=<C-R>c&check_keywords=yes&area=default"&'<CR>
vnoremap <silent> gxw "cy:exe ':silent !chromium "https://www.wikipedia.org/search-redirect.php?language=en&search=<C-R>c"&'<CR>
nnoremap <silent> gxg :exe ':silent !chromium "http://www.google.com/search?q=<cword>"&'<CR>
nnoremap <silent> gxp :exe ':silent !chromium "http://docs.python.org/3/search.html?q=<cword>&check_keywords=yes&area=default"&'<CR>
nnoremap <silent> gxw :exe ':silent !chromium "https://www.wikipedia.org/search-redirect.php?language=en&search=<cword>"&'<CR>
endif
""" `,m[m]`: run[echo] in term (two windows: one of them term)
nnoremap <leader>m yy<C-W><C-W><C-W>""<C-W><C-W>j
nnoremap <leader>mm yiw<C-W><C-W>echo $<C-W>""<CR><C-W><C-W>
vnoremap <leader>m y<C-W><C-W><C-W>""<CR><C-W><C-W>gv<ESC>j
vnoremap <leader>mm y<C-W><C-W>echo <C-W>""<CR><C-W><C-W>gv<ESC>
""" `,j2`: to jira (pip rst2confluence needed}
map <leader>j2 :py3 tojira()<CR>

"" plugins
"junegunn/fzf.vim
""" `sf` : fzf Files GFiles
map <silent> sf :Files<CR>
""" `sg` : fzf GFiles
map <silent> sg SD:GFiles<CR>
""" `sh`: fzf History
map <silent> sh :History<CR>
""" `sb`: fzf Buffers
map <silent> sb :Buffers<CR>
""" `s{.;:/}`: fzf Buffer tags, tags, : or / history
map <silent> s. :BTags<CR>
map <silent> s; :Tags<CR>
map <silent> s: :History:<CR>
map <silent> s/ :History/<CR>
map <silent> s/ :History/<CR>
"godlygeek/tabular
""" `,aa`: :Tabular
map <leader>aa :Tab/
"scrooloose/nerdtree
""" `sn`: NERDTreeToggle
nmap sn :NERDTreeToggle<CR>
""" `gx`: open browser and search
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
"": `:MM` build using Makeshift
command! -nargs=* MM :call s:BuildFun(<q-args>)
py3 << EOF
import uuid
import sys
import os
from unittest import mock
from math import *
import locale
locale.setlocale(locale.LC_ALL, '')
if sys.path[0]!='.':
    sys.path.insert(0,'.')
try:
    from docutils.core import publish_string
    from rst2confluence import confluence
    def tojira():
      vim.current.range[:]=publish_string(
        vim_current_range()[0],writer=confluence.Writer()).splitlines()
except: pass
EOF
iab FENV #!/usr/bin/env
iab FENC # encoding: utf-8
iab VIML # vim: ts=4 sw=4 sts=4 et noai nocin nosi inde=
iab Ydate <C-R>=strftime("%Y-%m-%d")<CR>
iab YY <C-R>=strftime("%Y%m%d")<CR>
iab YYY <C-R>=strftime("%Y%m%d%a")[:-2]<CR>
iab iGU <C-R>=py3eval("str(uuid.uuid4()).upper()")<CR>
iab iT t<C-R>=strftime("%S%M%H%d%m%Y")<CR>
