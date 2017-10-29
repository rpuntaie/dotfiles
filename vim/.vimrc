" Vim configuration file.
" Written by Fnux.

"NeoBundle --------------------------------------------------------------------

let g:bundledir=$HOME.'/.vim/neobundle'
let g:bundleinit=0

" Initialise and bootstrap NeoBundle (here goes my thanks to flor):
if has('vim_starting')
  if !isdirectory(g:bundledir)
    let g:bundleinit=1
    call mkdir(g:bundledir, 'p', 0700)
    !git clone 'https://github.com/Shougo/neobundle.vim' $HOME/.vim/neobundle/neobundle.vim
  endif
  set runtimepath+=$HOME/.vim/neobundle/neobundle.vim
endif

" List of bundles I use (including NeoBundle itself): "
call neobundle#begin(g:bundledir)
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'sheerun/vim-polyglot'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'kien/rainbow_parentheses.vim'

" Initial run requires NeoBundleInstall, as a simple 'Check' won't suffice:
if g:bundleinit
  NeoBundleInstall
else
  NeoBundleCheck
endif

call neobundle#end()

"Plugins config----------------------------------------------------------------

" Nerdtree
map <C-m> :NERDTreeToggle<CR>

" NeoComplete -> deoplete
let g:neocomplete#enable_at_startup = 1

" Vim-airline : display status bar
set laststatus=2

"Look--------------------------------------------------------------------------

" 256 colors
set t_Co=256

" Colorscheme
colorscheme jellybeans

" Statusline theme
let g:airline_theme='base16'

" Display and format line numbers.
set number
set numberwidth=4

" Enable UTF-8 (I wanna see Umlauts!).
set encoding=utf8

" Display tabs and trailing whitespaces.
set list
set listchars=tab:→\ ,eol:\ ,trail:·

" Conceallevel
set conceallevel=0

" Without any syntax highlighting, programming is a pain:
syntax on

" Colorcolumn color
highlight ColorColumn ctermbg=255

"Keybindings-------------------------------------------------------------------

" Leader key
let mapleader=","

" Save using sudo
cmap w!! w !sudo tee % >/dev/null

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Balance splits
nnoremap  <silent><leader>w <c-w>=

" Beginning/end of line
nnoremap  <silent><leader>a ^
nnoremap  <silent><leader>e $

" Toggle 'paste' with ,p.
nnoremap <leader>p :set invpaste paste?<CR>
imap <leader>p <C-O>:set invpaste paste?<CR>
set pastetoggle=<leader>p

" Neosnippet key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" Neosnippet superTab like snippets behavior.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Toggle colorcolumn
function! g:ToggleColorColumn()
  if &colorcolumn != 0
    setlocal colorcolumn=0
  else
    setlocal colorcolumn=80
  endif
endfunction
nnoremap <silent> <leader>h :call g:ToggleColorColumn()<CR>

"Misc--------------------------------------------------------------------------

if &compatible
  set nocompatible               " Be iMproved
endif
filetype plugin indent on

" Mouse support ("all")
set mouse=a

" Show command and mode.
set showcmd

" Make backspace work like most other apps.
set backspace=2

" Auto indentation.
set autoindent
set copyindent

" Folding
set foldmethod=indent

" Save the undo tree
if ! isdirectory($HOME . "/.vim/undo")
  call mkdir($HOME . "/.vim/undo", "p")
endif
set undofile
" Save it in ~/.vim/undo/.
set undodir=$HOME/.vim/undo

" Use spaces instead of tabs.
set expandtab
set tabstop=2
set shiftwidth=2

" Disable spelling.
set nospell

" More natural splits
set splitbelow
set splitright

" Fix unrecognised file types:
au BufRead,BufNewFile *.html.ecr setl filetype=html
