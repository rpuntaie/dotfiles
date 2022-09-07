hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "roland2"

hi Normal		ctermbg=Black  ctermfg=LightRed guibg=Black		 guifg=LightRed
hi Comment		term=bold	   ctermfg=DarkYellow guifg=DarkYellow
hi Constant		term=underline ctermfg=LightRed guifg=DarkGrey	gui=NONE
hi Identifier	term=underline ctermfg=DarkRed  guifg=DarkRed
hi Ignore					   ctermfg=black	  guifg=bg
hi PreProc		term=underline ctermfg=LightGreen  guifg=Wheat
hi Search	term=bold  ctermbg=DarkGrey ctermfg=White guifg=DarkGrey guibg=White
hi Special		term=bold	   ctermfg=LightGreen   guifg=magenta
hi Statement	term=bold	   ctermfg=Yellow	  guifg=Yellow gui=NONE
hi Type						   ctermfg=LightRed guifg=grey	gui=none
hi Error		term=reverse   ctermbg=Red	  ctermfg=DarkGrey guibg=Red  guifg=DarkGrey
hi Todo			term=standout  ctermbg=Red ctermfg=Black guifg=Black guibg=Red
hi Cursor										  guifg=Orchid	guibg=fg
hi Directory	term=bold	   ctermfg=LightRed  guifg=LightRed
hi ErrorMsg		term=standout  ctermbg=DarkRed	  ctermfg=lightgrey guibg=Red guifg=DarkGrey
hi IncSearch	term=reverse   cterm=reverse	  gui=reverse
hi LineNr		term=underline ctermfg=DarkGray					guifg=DarkGray
hi ModeMsg		term=bold	   cterm=bold		  gui=bold
hi MoreMsg		term=bold	   ctermfg=LightRed gui=bold		guifg=SeaGreen
hi NonText		term=bold	   ctermbg=Black	  ctermfg=Red guibg=Black guifg=Red
hi Question		term=standout  ctermfg=DarkRed gui=bold		guifg=DarkRed
hi SpecialKey	term=bold	   ctermfg=LightGreen  guifg=LightGreen
hi StatusLine	term=reverse,bold cterm=reverse   gui=NONE		guifg=Black guibg=grey
hi StatusLineNC term=reverse   cterm=reverse	  gui=NONE		guifg=DarkGrey guibg=#333333
hi Title		term=bold	   ctermfg=LightMagenta gui=bold	guifg=Pink
hi WarningMsg	term=standout  ctermfg=LightGreen   guifg=Red
hi Visual		term=reverse   cterm=reverse	  gui=NONE		guifg=DarkGrey guibg=darkgreen
hi Folded		term=bold      cterm=bold   ctermbg=DarkGreen	  gui=NONE		guifg=DarkGrey guibg=DarkGreen

hi ColorColumn ctermbg=DarkRed guibg=DarkRed
hi Pmenu ctermbg=Black ctermfg=Green guibg=black
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red guibg=DarkRed guifg=Black
hi User2 ctermbg=DarkGreen ctermfg=Black guibg=DarkGreen guifg=Black
