iab FENV #!/usr/bin/env
iab FENC # encoding: utf-8
iab Ydate <C-R>=strftime("%Y-%m-%d")<CR>
iab YY <C-R>=strftime("%Y%m%d")<CR>
iab YYY <C-R>=strftime("%Y%m%d%a")[:-2]<CR>
iab iGU <C-R>=py3eval("str(uuid.uuid4()).upper()")<CR>
iab iT t<C-R>=strftime("%S%M%H%d%m%Y")<CR>
iab iC <C-R>=py3eval("iC()")<CR>
iab iF <C-R>=py3eval("iF()")<CR>
