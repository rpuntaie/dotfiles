" trailing whitespaces:
set list
set listchars=tab:→\ ,eol:\ ,trail:·
function! ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction
function! TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///ge"
  let &hlsearch=oldhlsearch
endfunction
command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
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
" Visual mode pressing * or # searches for the current region
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>
" Open vimgrep and put the cursor in the right position
nnoremap <leader>gg :vimgrep // **/*<C-B><S-right><right><right>
" vimgrep after the selected text
vnoremap <leader>gg :call VisualSelection('gv', '**/*')<CR>:<C-U><C-R>=@g<CR>
" .. in buffers
vnoremap <leader>gb :call VisualSelection('gv', '')<CR>:<C-U><C-R>=@g<CR>
" Search and replace the selected text
vnoremap <leader>gr :call VisualSelection('replace', '')<CR>:<C-U><C-R>=@g<CR>


func! GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command! -nargs=? G call GitGrep(<f-args>)
func! GitGrepWord()
  normal! "zyiw
  call GitGrep('-w -e ', getreg('z'))
endf
nmap <C-x>G :call GitGrepWord()<CR>


" read from a shell command into a new buffer
function! s:RunShellCommand(cmdline)
    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    setlocal nowrap
    call setline(1,a:cmdline)
    call setline(2,substitute(a:cmdline,'.','=','g'))
    call setpos('.',[0,2,1,0])
    execute 'silent read !'.escape(a:cmdline,'%#')
    setlocal nomodifiable
    1 "goes to first line
endfunction
command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)

function! DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call DiffWithSaved()
map <Leader>ds :DiffSaved<CR>

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
