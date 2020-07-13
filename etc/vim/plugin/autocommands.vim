augroup rolandau
    autocmd!
    " Return to last edit position when opening files
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif

    autocmd BufReadPre *.rest setlocal syntax=rst
    autocmd BufEnter * :syntax sync fromstart
    autocmd BufEnter *.py :set equalprg=autopep8\ -
augroup END
