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
"
" Status Line
set statusline=%n%m%r%h%w\ %04v,%04l=%p%%(%L)\ 0x%B[%{ShowUtf8Sequence()}]
set statusline+=%{getcwd()}>%f\ %=\[%{&ff}\ %{&fenc==\"\"?&enc:&fenc}]
set laststatus=2
