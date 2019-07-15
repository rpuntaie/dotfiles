" see also the mappings in plugins.vim
nnoremap <kPlus>      :cnext<CR>
nnoremap <kMinus>     :cprev<CR>
nnoremap <kMultiply>  :cc<CR>
" Treat long lines as break lines when wrap on
map j gj
map k gk
" Redo syntax fromstart
noremap <leader>sx <Esc>:syntax sync fromstart<CR>
" Ctrl+c/Ctrl+v to copy/paste (clipboard) in gvim
nmap <C-V> "+gP
imap <C-V> <ESC><C-V>i
vmap <C-C> "+y
" Move around windows
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
" Don't close window, when deleting a buffer
map <leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>
" look up in wordnet (wn)
nmap <leader>ww :!wn <C-R><C-W> -over<CR>
" remember word at beginning of text file
nmap <leader>we mwywggO<ESC>p0*'wn:!wn <C-R><C-W> -over<CR>
nnoremap Y y$
" Replace without loosing register
vnoremap R "_c<C-R>"<esc>
nnoremap R "_ciw<C-R>"<esc>
" Insert empty line
nnoremap <silent> s <nop>
nnoremap <silent> S <nop>
nnoremap <silent> ss o<ESC>k
" Language used in insert mode
nmap <leader>lr :set keymap=russian-jcukenwin<cr>
nmap <leader>la :set keymap=accents<cr>
nmap <leader>lm :set keymap=mathematic<cr>
nmap <leader>lj :set keymap=<cr>
nmap <leader>lk :set keymap=fntc<cr>
" spell
nmap <leader>ls :setlocal spell spelllang=
" edit
nmap <leader>ee :e $MYVIMRC<cr>
nmap <leader>ep :e <C-R>=g:dein_path<cr>/../..<cr>
" numbering
vnoremap <leader>ecc :'<'>!cat -n<cr>
" renumber
vnoremap <leader>ec :<bs><bs><bs><bs><bs>let c=0\|'<,'>g/^\s*\d/let c=c+1\|s/\d/\=c<cr>
"yank current file full path
noremap <silent> cp :let @* = expand("%:p")<CR>
"match move
onoremap <silent>m //e<CR>
vnoremap <silent>m //e<CR>
nnoremap <silent>n //<CR>
":CD to path of current file
command! CD cd %:p:h
"CD to symlinked path
nnoremap <silent> CD :cd <C-R>=fnamemodify(resolve(expand('%:p')),':p:h')<CR><CR>
"show todo
command! TD :cexpr system('todo')
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
nmap <leader>fs :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>fg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>fc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ft :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>fe :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ff :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>fi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader>fd :cs find d <C-R>=expand("<cword>")<CR><CR>
" see py3.vim
map <leader>j2 :py3 tojira()<CR>

" s[hell] l[ocal],n[onlocal],google,python,wikipedia
vnoremap <silent> <leader>sl "cy:call netrw#BrowseX("<C-R>=expand("%:p:h")<CR>/<C-R>c",0)<CR><CR>
vnoremap <silent> <leader>sn "cy:call netrw#BrowseX("<C-R>c",0)<CR><CR>
nnoremap <silent> <leader>sl :call netrw#BrowseX('<C-R>=expand("%:p:h")<CR>/<C-R>=expand("<cWORD>")<CR>',0)<CR>
nnoremap <silent> <leader>sn :call netrw#BrowseX('<C-R>=expand("<cWORD>")<CR>',0)<CR>
if has("win32")
vnoremap <silent> <leader>sg "cy:!start /b cmd /c chromium "www.google.com/search?q=<C-R>c"<CR><CR>
vnoremap <silent> <leader>sp "cy:!start /b cmd /c chromium "http://docs.python.org/py3k/search.html?q=<C-R>c&check_keywords=yes&area=default"<CR><CR>
vnoremap <silent> <leader>sw "cy:!start /b cmd /c chromium "https://www.wikipedia.org/search-redirect.php?language=en&search=<C-R>c"<CR><CR>
nnoremap <silent> <leader>sg :!start /b cmd /c chromium "http://www.google.com/search?q=<cword>"<CR>
nnoremap <silent> <leader>sp :!start /b cmd /c chromium "http://docs.python.org/py3k/search.html?q=<cword>&check_keywords=yes&area=default"<CR>
nnoremap <silent> <leader>sw :!start /b cmd /c chromium "https://www.wikipedia.org/search-redirect.php?language=en&search=<cword>"<CR>
else
vnoremap <silent> <leader>sg "cy:exe ':silent !chromium "www.google.com/search?q=<C-R>c"&'<CR><CR>
vnoremap <silent> <leader>sp "cy:exe ':silent !chromium "http://docs.python.org/py3k/search.html?q=<C-R>c&check_keywords=yes&area=default"&'<CR><CR>
vnoremap <silent> <leader>sw "cy:exe ':silent !chromium "https://www.wikipedia.org/search-redirect.php?language=en&search=<C-R>c"&'<CR><CR>
nnoremap <silent> <leader>sg :exe ':silent !chromium "http://www.google.com/search?q=<cword>"&'<CR>
nnoremap <silent> <leader>sp :exe ':silent !chromium "http://docs.python.org/py3k/search.html?q=<cword>&check_keywords=yes&area=default"&'<CR>
nnoremap <silent> <leader>sw :exe ':silent !chromium "https://www.wikipedia.org/search-redirect.php?language=en&search=<cword>"&'<CR>
endif
" With two windows, one term, run the current line or visual area in term
nnoremap <leader>sm yy<C-W><C-W><C-W>""<C-W><C-W>j
vnoremap <leader>sm y<C-W><C-W><C-W>""<C-W><C-W>gv<ESC>

" digraphs
dig ll 2113
dig II 120129
dig NN 8469
dig ZZ 8484
dig QQ 8474
dig RR 8477
dig CC 8450
dig @e 601 "ə schwa
dig @a 592 "ɐ open-mid schwa
dig @C 643 "ʃ vl postalveolar fricative
dig @c 658 "ʒ vd postalveolar fricative
dig @R 641 "ʁ vd uvular fricative
dig @X 967 "χ vl uvular fricative
dig @l 654 "ʎ italian gli, castillian ll

