function! ShowUtf8Sequence()
  let p = getpos('.')
  redir => utfseq
  silent normal! g8
  redir End
  call setpos('.',p)
  return '['.trim(utfseq).']'
endfunction
function! ChangeStatuslineColor()
  if (mode() =~# '\v(n|no)')
    exe 'hi! StatusLine ctermfg=008'
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! StatusLine ctermfg=005'
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine ctermfg=004'
  else
    exe 'hi! StatusLine ctermfg=006'
  endif
  return ''
endfunction
function! GitInfo()
  if !exists('fugitive#head')
    return ''
  endif
  let git = fugitive#head()
  if git != ''
    return ''.fugitive#head().''
  else
    return ''
  endif
endfunction
set statusline= " --------- left side ---------
set statusline+=%1*[%n] " buffer number
set statusline+=%m " modified
set statusline+=%2*%{GitInfo()}
set statusline+=%0*%{getcwd()}\> " dir
set statusline+=%1*%f " file
set statusline+=%=%< " --------- right side ---------
set statusline+=%0*\[%{&ff}] " fileformat
set statusline+=\[%{&fenc==\"\"?&enc:&fenc}] " (file) encoding
set statusline+=%y " filetype
set statusline+=%r " readonly flag
set statusline+=%w " preview flag
set statusline+=%2*%p%%(%L)%04v,%04l " c, l = % (total lines)

"https://github.com/vim/vim/issues/6447: insert <CursorHold> after updatetime
set statusline+=%1*%{ShowUtf8Sequence()} " utf-8

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
:hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red guibg=DarkRed guifg=Black
:hi User2 term=inverse,bold cterm=inverse,bold ctermfg=blue guibg=DarkGreen guifg=Black
set laststatus=2
