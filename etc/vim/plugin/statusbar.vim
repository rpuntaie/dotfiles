function! ShowUtf8Sequence()
  if (mode()=='i' && exists('b:thch'))
      return nr2char(b:thch)
  endif
  let p = getpos('.')
  redir => utfseq
  silent normal! g8
  redir End
  call setpos('.', p)
  return substitute(matchstr(utfseq, '\x\+ .*\x'), '\<\x', '0x&', 'g')
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
    return ' '.fugitive#head()
  else
    return ''
endfunction
set statusline=
set statusline+=%8*\ %n
set statusline+=%0*%m
set statusline+=%r
set statusline+=%h
set statusline+=%w
set statusline+=\ %04v,%04l=%p%%(%L)
set statusline+=\ 0x%B[%{ShowUtf8Sequence()}]
set statusline+=\ %{getcwd()}\>%8*%f%=
set statusline+=%0*\[%{&ff}\ %{&fenc==\"\"?&enc:&fenc}]
set statusline+=%y
set statusline+=\ %{GitInfo()}
set laststatus=2
