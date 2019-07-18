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
  let git = fugitive#head()
  if git != ''
    return ''.fugitive#head().''
  else
    return ''
endfunction
set statusline= " --------- left side ---------
set statusline+=%8*[%n] " buffer number
set statusline+=%m " modified
set statusline+=%0*%{GitInfo()}
set statusline+=%{getcwd()}\> " dir
set statusline+=%8*%f " file
set statusline+=%= " --------- right side ---------
set statusline+=%0*\[%{&ff}] " fileformat
set statusline+=\[%{&fenc==\"\"?&enc:&fenc}] " (file) encoding
set statusline+=%y " filetype
set statusline+=%r " readonly flag
set statusline+=%w " preview flag
set statusline+=\ %04v,%04l=%p%%(%L) " c, l = % (total lines)
set statusline+=\ %{ShowUtf8Sequence()} " utf-8
set laststatus=2
