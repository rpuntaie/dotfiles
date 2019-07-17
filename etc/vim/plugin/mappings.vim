""" `Y`: yank till end of line, like D
nnoremap Y y$
""" `R`: Replace from default register without loosing it
vnoremap R "_c<C-R>"<esc>
nnoremap R "_ciw<C-R>"<esc>
""" `{jk}=g{jk}`: treat as break lines when wrap on
map j gj
map k gk
""" {ss SS} " Insert empty line below|above
map <silent> s <nop>
map <silent> S <nop>
nnoremap <silent> ss o<ESC>k
nnoremap <silent> SS O<ESC>j
""" `+-*`: numberpad quickfix move
nnoremap <kPlus>      :cnext<CR>
nnoremap <kMinus>     :cprev<CR>
nnoremap <kMultiply>  :cc<CR>
""" `sx`: syntax fromstart
noremap sx <Esc>:syntax sync fromstart<CR>
""" `<C-V>|<C-C>`: copy|paste clipboard in gvim
nmap <C-V> "+gP
imap <C-V> <ESC><C-V>i
vmap <C-C> "+y
""" `<C-{kjhl}>`: go to window
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
""" `,bd`: close buffer, but not window
map <leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>
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
""" `cp`: yank current file full path
noremap <silent> cp :let @* = expand("%:p")<CR>
""" `m`: match in o v n mode
onoremap <silent>m //e<CR>
vnoremap <silent>m //e<CR>
nnoremap <silent>n //<CR>
"": `:CD`: cd to current file
command! CD cd %:p:h
""" `CD`: cd to current symlinked file
nnoremap <silent> CD :cd <C-R>=fnamemodify(resolve(expand('%:p')),':p:h')<CR><CR>
"": `:TD` execute .local/bin/todo to quickfix list
command! TD :cexpr system('~/.local/bin/todo')
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
""" `,j2`: to jira (pip rst2confluence needed}
map <leader>j2 :py3 tojira()<CR>
""" `gx{lngpw}`: open local, nonlocal; google,python,wikipedia
vnoremap <silent> gxl "cy:call netrw#BrowseX("<C-R>=expand("%:p:h")<CR>/<C-R>c",0)<CR><CR>
vnoremap <silent> gxn "cy:call netrw#BrowseX("<C-R>c",0)<CR><CR>
nnoremap <silent> gxl :call netrw#BrowseX('<C-R>=expand("%:p:h")<CR>/<C-R>=expand("<cWORD>")<CR>',0)<CR>
nnoremap <silent> gxn :call netrw#BrowseX('<C-R>=expand("<cWORD>")<CR>',0)<CR>
if has("win32")
vnoremap <silent> gxg "cy:!start /b cmd /c chromium "www.google.com/search?q=<C-R>c"<CR><CR>
vnoremap <silent> gxp "cy:!start /b cmd /c chromium "http://docs.python.org/py3k/search.html?q=<C-R>c&check_keywords=yes&area=default"<CR><CR>
vnoremap <silent> gxw "cy:!start /b cmd /c chromium "https://www.wikipedia.org/search-redirect.php?language=en&search=<C-R>c"<CR><CR>
nnoremap <silent> gxg :!start /b cmd /c chromium "http://www.google.com/search?q=<cword>"<CR>
nnoremap <silent> gxp :!start /b cmd /c chromium "http://docs.python.org/py3k/search.html?q=<cword>&check_keywords=yes&area=default"<CR>
nnoremap <silent> gxw :!start /b cmd /c chromium "https://www.wikipedia.org/search-redirect.php?language=en&search=<cword>"<CR>
else
vnoremap <silent> gxg "cy:exe ':silent !chromium "www.google.com/search?q=<C-R>c"&'<CR><CR>
vnoremap <silent> gxp "cy:exe ':silent !chromium "http://docs.python.org/py3k/search.html?q=<C-R>c&check_keywords=yes&area=default"&'<CR><CR>
vnoremap <silent> gxw "cy:exe ':silent !chromium "https://www.wikipedia.org/search-redirect.php?language=en&search=<C-R>c"&'<CR><CR>
nnoremap <silent> gxg :exe ':silent !chromium "http://www.google.com/search?q=<cword>"&'<CR>
nnoremap <silent> gxp :exe ':silent !chromium "http://docs.python.org/py3k/search.html?q=<cword>&check_keywords=yes&area=default"&'<CR>
nnoremap <silent> gxw :exe ':silent !chromium "https://www.wikipedia.org/search-redirect.php?language=en&search=<cword>"&'<CR>
endif
""" `sm`: run in term (two windows, one term)
nnoremap sm yy<C-W><C-W><C-W>""<C-W><C-W>j
vnoremap sm y<C-W><C-W><C-W>""<C-W><C-W>gv<ESC>

