set keymodel=startsel,stopsel
set selection=exclusive
set noswapfile
filetype plugin indent off
set history=700
set autoread
set isfname-=: " to make gF open file:line 
set iskeyword=@,48-57,_,180-255 "word delimiters
set fillchars+="fold: "
set foldmethod=marker
set showtabline=0
set scrolloff=1
set wildmenu
set cmdheight=2
set hidden
set nobackup
set nowb
set autowriteall
set backspace=indent,eol,start
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=2
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set mousehide
set nowrap
set ffs=unix,dos,mac
if has("multi_byte") " type '8g8' to find illegal utf8
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1,cp1251
endif
set list
set listchars=tab:→\ ,eol:\ ,trail:·
set nosmarttab
set noautoindent
set nosmartindent
set indentexpr=
set shiftwidth=4
set tabstop=4
set softtabstop=0
set expandtab
set clipboard=unnamed
map <middlemouse> <nop>
imap <middlemouse> <nop>
nnoremap <X1Mouse> <C-O>
nnoremap <X2Mouse> <C-I>
set tags=./.tags;,.tags;
if filereadable($MY.'/.tags')
  set tags+=$MY/.tags
endif
set errorformat=%f:%l:%c:%m
set errorformat+=%f:%l:%m
set errorformat+=%f(%l)\ :\ %m
set errorformat+=%f:%l\\,\ E:%n:\ %m
set errorformat+=\|\|\ %f:%l:%m
"makeprg set by vim-makeshift
if has("gui_running") || has('nvim')
  set shellcmdflag=-ic
endif
set diffopt+=iwhite
syntax on
set background=dark
colorscheme murphy
if has("gui_running")
    set guicursor=n-c:block-Cursor/lCursor-blinkon0
    set guicursor+=i-ci:ver30-Cursor/lCursor-blinkon0
    set guicursor+=r-cr:hor20-Cursor/lCursor
    set guicursor+=v:ver50-Cursor/lCursor-blinkon0
    set lines=999
    set columns=175
    winpos 0 0
    set guiheadroom=0
    set guioptions=a
    if has("win32")
        "set guifont=DejaVu\ Sans\ Mono:h9:cANSI
        "set guifont=Inconsolata\ Bold\ 10
        if filereadable("C:/Windows/Fonts/FreeMonoBoldFO4.ttf")
            set guifont=FreeMonoFO4:h10:b:cANSI
        else
            set guifont=FreeMono:h10:b:cANSI
        endif
    else
        if filereadable($HOME."/.local/share/fonts/FreeMonoBoldFO4.ttf")
          set guifont=FreeMonoFO4\ Bold\ 11
        else
          set guifont=FreeMono\ Bold\ 11
        endif
    endif
  endif
let g:terminal_ansi_colors = [ "#373c40", "#ff5454", "#8cc85f", "#e3c78a",
  \ "#80a0ff", "#ce76e8", "#7ee0ce", "#de935f", "#f09479", "#f74782",
  \ "#42cf89", "#cfcfb0", "#78c2ff", "#ae81ff", "#85dc85", "#e2637f" ]
"check width
set colorcolumn=+1
hi ColorColumn ctermbg=232 guibg=#080808
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
highlight Pmenu ctermbg=Black ctermfg=Green guibg=black
