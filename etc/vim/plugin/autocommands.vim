" Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif

autocmd bufreadpre *.rest setlocal syntax=rst
autocmd BufEnter * :syntax sync fromstart
