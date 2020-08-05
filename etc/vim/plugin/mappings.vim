""" `Y`: yank till end of line, like D
nnoremap Y y$
""" `s`: <nop>, free for other mappings
map <silent> s <nop>
map <silent> S <nop>
""" `{ss SS}`: n insert char before|after
nnoremap ss :exec "normal i".nr2char(getchar())."\e"<CR>
nnoremap SS :exec "normal a".nr2char(getchar())."\e"<CR>
""" `{sj sk}`: Insert empty line below|above
nnoremap <silent> sj o<ESC>k
nnoremap <silent> sk O<ESC>j
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
nnoremap sx <Esc>:syntax sync fromstart<CR>
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
nnoremap <leader>s :update<CR>
""" `,S`: commit current buffer to git
nnoremap <leader>S :Gw<CR>:Gcommit<CR>
""" `,b{d w}`: delete/wipe buffer, but not window
map <leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>
map <leader>bw :bp<bar>sp<bar>bn<bar>bw<CR>
""" `,l{ramkj}`: load russian accents mathematic fntc english
nmap <leader>lr :set keymap=russian-jcukenwin<CR>
nmap <leader>la :set keymap=accents<CR>
nmap <leader>lm :set keymap=mathematic<CR>
nmap <leader>lj :set keymap=<CR>
nmap <leader>lk :set keymap=fntc<CR>
""" `,ls`: load spelling
nmap <leader>ls :setlocal spell spelllang=
""" `,e{ep}`: edit vimrc | dein repos
nmap <leader>ee :e 
nmap <leader>ev :e $MYVIMRC<CR>
function! s:EditMappings()
    execute "e ".fnamemodify(expand($MYVIMRC),':h') . '/plugin/mappings.vim'
endfunction
nmap <leader>evm :call <SID>EditMappings()<CR>
nmap <leader>ep :e <C-R>=g:dein_path<CR>/../..<CR>
nmap <leader>em :e $MY<CR>
"vim-scripts/vcscommand.vim
""" `,tt`: google translate
nnoremap <silent> <leader>tt :Trans<CR>
vnoremap <silent> <leader>tt :Trans<CR>
""" `,ww`: look up in wordnet (wn needed)
nnoremap <leader>ww :!wn <C-R><C-W> -over<CR>
""" `sc[c]`: (re)number
vnoremap scc :'<'>!cat -n<CR>
vnoremap sc :<bs><bs><bs><bs><bs>let c=0\|'<,'>g/^\s*\d/let c=c+1\|s/\d/\=c<CR>
""" `sp`: yank current file full path
nnoremap <silent> sp :let @* = expand("%:p")<CR>
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
""" `<C-n>`: NERDTreeToggle
map <C-n> :NERDTreeToggle<CR>
""" `gx{lngpw}`: open local, nonlocal; chromium google,python,wikipedia
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
""" `gx`: open browser (normally firefox) and search
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
""" `,vt{ bipgcrs(s)h}`: vert term Bash|Ipython|Perl|Ghci|Cling|R|(p)Sql|pHp|java
"exit
nnoremap <silent> <leader>v :vert term<CR>
"exit
nnoremap <silent> <leader>vb :vert term bash<CR>
"? exit
nnoremap <silent> <leader>vi :vert term ipython<CR>
"C-d
nnoremap <silent> <leader>vii :vert term irb<CR>
"C-d
nnoremap <silent> <leader>vp :vert term re.pl<CR>
":? :q
nnoremap <silent> <leader>vg :vert term ghci<CR>
":help :quit
nnoremap <silent> <leader>vgg :vert term gore<CR>
".? .q
nnoremap <silent> <leader>vc :vert term cling<CR>
"help; quit;
nnoremap <silent> <leader>vcc :vert term csharp<CR>
"help() q()
nnoremap <silent> <leader>vr :vert term R<CR>
":h :q
nnoremap <silent> <leader>vs :vert term scala<CR>
":help :quit
nnoremap <silent> <leader>vk :vert term kotlin<CR>
".help .q
nnoremap <silent> <leader>vq :vert term sqlite3<CR>
"\? \q
nnoremap <silent> <leader>vqq :vert term psql<CR>
"help exit
nnoremap <silent> <leader>vh :vert term psysh<CR>
"? C-d
nnoremap <silent> <leader>vj :vert term julia<CR>
"/help /exit
nnoremap <silent> <leader>vjj :vert term jshell<CR>
"quit
nnoremap <silent> <leader>vl :vert term planck<CR>
"(quit)
nnoremap <silent> <leader>vll :vert term lein repl<CR>
"C-d
nnoremap <silent> <leader>vn :vert term node<CR>
"help doc quit
nnoremap <silent> <leader>vo :vert term octave<CR>
"C-c
nnoremap <silent> <leader>vm :vert term ocaml<CR>
"C-d (yay -S j9-git)
nnoremap <silent> <leader>v9 :vert term j9 --console<CR>
"C-d
nnoremap <silent> <leader>va :vert term lua<CR>
"C-c h() (elixir)
nnoremap <silent> <leader>vx :vert term iex<CR>
"<C-d> :help (yay -S evcxr_repl) (rust)
nnoremap <silent> <leader>ve :vert term evcxr<CR>
",help C-d
nnoremap <silent> <leader>vu :vert term guile<CR>

""" `,m[m]`: run[echo] in term (two windows: one of them term)
nnoremap <leader>m yy<C-W><C-W><C-W>""<C-W><C-W>j
nnoremap <leader>mm yiw<C-W><C-W>echo $<C-W>""<CR><C-W><C-W>
vnoremap <leader>m y<C-W><C-W><C-W>""<CR><C-W><C-W>gv<ESC>j
vnoremap <leader>mm y<C-W><C-W>echo <C-W>""<CR><C-W><C-W>gv<ESC>
""" `,hh`: haskell block
vnoremap <leader>hh y<C-W><C-W>:{<CR><C-W>""<CR>:}<CR><C-W><C-W>gv<ESC>j
nnoremap <leader>hh yiw<C-W><C-W>:hoogle <C-W>""<CR><C-W><C-W>
""" `,{vv mv}`: vim eval
vnoremap <leader>vv y:@"<CR>
nnoremap <leader>vv yy:@"<CR>
vnoremap <leader>mv y:echo <C-R>"<CR>
nnoremap <leader>mv yiw:echo <C-R>"<CR>
""" `,j2`: to jira ("pip install rst2jira" needed}
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
"godlygeek/tabular
""" `,aa`: :Tabular
map <leader>aa :Tab/
"scrooloose/nerdtree
""" `sn`: NERDTreeToggle
nmap sn :NERDTreeToggle<CR>
"coc

nmap <leader>i :CocEnable<CR>
nmap <leader>ii :CocDisable<CR>
let g:coc_user_config['suggest.triggerCompletionWait'] = 500
"let g:coc_user_config['suggest.autoTrigger'] = 'trigger'
"inoremap <silent><expr> <c-space> coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
if exists('*complete_info')
  inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
""" `{[]}g` coc diagnostic next/prev
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
""" `g{dyir}` coc go to definition/type/implementation/reference
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
""" `KK` coc documentation (K is man page)
nnoremap <silent> KK :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
""" `rn` rename
nmap <leader>rn <Plug>(coc-rename)
""" `lf` format
xmap <leader>lf  <Plug>(coc-format-selected)
nmap <leader>lf  <Plug>(coc-format-selected)
augroup cocau
  autocmd!
  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
""" `l{ac}` coc load codeaction for selected (a) or all (c)ode
xmap <leader>la  <Plug>(coc-codeaction-selected)
nmap <leader>la  <Plug>(coc-codeaction-selected)
nmap <leader>lc  <Plug>(coc-codeaction)
""" `lc` coc fix current
nmap <leader>qf  <Plug>(coc-fix-current)
""" `{ia}{fc}` coc select inside/outside function/class
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
""" `<C-s>` select next range
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
"": `:Format` coc format
command! -nargs=0 Format :call CocAction('format')
"": `:Fold` coc fold
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"": `:OR` coc organize import
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
""" `<space>`X coc list (a)diagnostic/(e)xtension/(c)ommand/(o)utline/(s)ymbols (p)resume (j/k) next/prev
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<CR>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<CR>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<CR>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<CR>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<CR>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"end coc

"": `:MM` build using Makeshift
function! s:BuildFun(what2build)
    execute 'Makeshift'
    execute 'MakeshiftBuild '.a:what2build
endfunction
command! -nargs=* MM :call <SID>BuildFun(<q-args>)
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
""i `FENV #!/usr/bin/env`
iab FENV #!/usr/bin/env
""i `FENC # encoding: utf-8`
iab FENC # encoding: utf-8
""i `VIML # vim: ts=4 sw=4 sts=4 et noai nocin nosi inde=`
iab VIML # vim: ts=4 sw=4 sts=4 et noai nocin nosi inde=
""i `Ydate 2020-07-11`
iab Ydate <C-R>=strftime("%Y-%m-%d")<CR>
""i `YY 20200711`
iab YY <C-R>=strftime("%Y%m%d")<CR>
""i `YYY 20200711Sa`
iab YYY <C-R>=strftime("%Y%m%d%a")[:-2]<CR>
""i `iGU B6785F62-0A3B-4AFF-A5AA-0AFB2FEEF9F3`
iab iGU <C-R>=py3eval("str(uuid.uuid4()).upper()")<CR>
""i `iT t50282011072020`
iab iT t<C-R>=strftime("%S%M%H%d%m%Y")<CR>

