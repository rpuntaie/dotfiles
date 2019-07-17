" trailing whitespaces:
function! TrimSpaces() range
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  let &hlsearch=1
  execute a:firstline.",".a:lastline."substitute ///ge"
  let &hlsearch=oldhlsearch
endfunction
"": `:TrimSpaces` accepts range
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()

function! DoPrettyXML()
  let l:origft = &ft
  set ft=
  1s/<?xml .*?>//e
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  2d
  $d
  silent %<
  1
  exe "set ft=" . l:origft
endfunction
"": `:PrettyXML` format XML
command! PrettyXML call DoPrettyXML()

function! VisualSelection(direction, ffilter) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  elseif a:direction == 'gv'
    if a:ffilter == ''
      let allbufs = range(0, bufnr('$'))
      let res = []
      for b in allbufs
        if buflisted(b)
          call add(res, bufname(b))
        endif
      endfor
      let l:ffilter = join(res)
    else
      let l:ffilter = a:ffilter
    endif
    let @g="vimgrep " . '/'. l:pattern . '/ ' . l:ffilter
  elseif a:direction == 'replace'
    let @g="%s" . '/'. l:pattern . '/'
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction
""" `*#`: search down|up on visual region
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>
""" `,gr`: specify replace for visual region
vnoremap <leader>gr :call VisualSelection('replace', '')<CR>:<C-U><C-R>=@g<CR>
""" `,gg`: vimgrep specify or visual region
""" `,gb`: vimgrep in buffers
nnoremap <leader>gg :vimgrep // **/*<C-B><S-right><right><right>
vnoremap <leader>gg :call VisualSelection('gv', '**/*')<CR>:<C-U><C-R>=@g<CR>
vnoremap <leader>gb :call VisualSelection('gv', '')<CR>:<C-U><C-R>=@g<CR><CR>


" read from a ex or shell command into a new scratch buffer
function! Redir(cmd)
  for win in range(1, winnr('$'))
    if getwinvar(win, 'scratch')
      execute win . 'windo close'
    endif
  endfor
  if a:cmd =~ '^!'
    let output = system(matchstr(a:cmd, '^!\zs.*'))
  else
    redir => output
    execute a:cmd
    redir END
  endif
  botright vnew
  let w:scratch = 1
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, split(output, "\n"))
endfunction
"": `:Redir` either shell or vim command
command! -nargs=+ -complete=command Redir silent call Redir(<q-args>)

function! DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call DiffWithSaved()

if has('win32')
  set diffexpr=MyDiff()
  function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    if $VIMRUNTIME =~ ' '
      if &sh =~ '\<cmd'
        if empty(&shellxquote)
          let l:shxq_sav = ''
          set shellxquote&
        endif
        let cmd = '"' . $VIMRUNTIME . '\diff"'
      else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
      endif
    else
      let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
      let &shellxquote=l:shxq_sav
    endif
  endfunction
endif
