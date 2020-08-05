augroup rolandau
    autocmd!
    " Return to last edit position when opening files
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif

    autocmd BufReadPre *.rest setlocal syntax=rst
    autocmd BufEnter * :syntax sync fromstart

    autocmd BufEnter * :set equalprg=
    autocmd BufEnter *.py :set equalprg=autopep8\ -
    autocmd BufEnter *.js :set equalprg=js-beautify\ -
    autocmd BufEnter *.html :set equalprg=js-beautify\ --type\ html\ -
    autocmd BufEnter *.go :set equalprg=gofmt
    autocmd BufEnter *.c :set equalprg=clang-format\ -i
    autocmd BufEnter *.cpp :set equalprg=clang-format\ -i

augroup END
