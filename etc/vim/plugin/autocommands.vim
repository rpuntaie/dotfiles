" Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
" redo syntax on entering a buffer
autocmd bufreadpre *.rest setlocal syntax=rst
autocmd BufEnter * :syntax sync fromstart
