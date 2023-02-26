# -*- coding: utf-8 -*-

#sphinx config file used in ../bin/sphinxbuild1

# Deprecation
# The sphinxcontrib packages lag behind sphinx.
# I use rstdoc now, which keeps tikz and the like in separate files.

# pip install --user git+https://bitbucket.org/philexander/tikz/src/master/
# pip install --user git+https://github.com/prometheusresearch/sphinxcontrib-texfigure

import re,os.path

extensions = ['sphinx.ext.todo',
'sphinx.ext.autodoc',
'sphinx.ext.napoleon',
'sphinx.ext.mathjax',
'sphinxcontrib.tikz',
'sphinxcontrib.texfigure']
# Napoleon settings
napoleon_google_docstring = True
napoleon_numpy_docstring = True
napoleon_include_init_with_doc = False
napoleon_include_private_with_doc = False
napoleon_include_special_with_doc = False
napoleon_use_admonition_for_examples = False
napoleon_use_admonition_for_notes = False
napoleon_use_admonition_for_references = False
napoleon_use_ivar = False
napoleon_use_param = True
napoleon_use_rtype = True
napoleon_use_keyword = True
templates_path = ['.']#with page.html containing only {{body}}
html_sidebars = {
    '**': []
}
source_suffix = '.rst'
source_encoding = 'utf-8'
default_role = 'math'
pygments_style = 'sphinx'
tikz_transparent = True
tikz_proc_suite = 'ImageMagick'
tikz_tikzlibraries = 'arrows,snakes,backgrounds,patterns,matrix,shapes,fit,calc,shadows,plotmarks,intersections'
project = 'Project'
exclude_patterns = ['_build']
latex_engine = 'xelatex'
latex_show_urls = 'footnote'

_pandoc_latex_pdf = [
    '--listings', '--number-sections', '--pdf-engine', 'xelatex', '-V',
    'titlepage', '-V', 'papersize=a4', '-V', 'toc', '-V', 'toc-depth=3', '-V',
    'geometry:margin=2.5cm'
     , '-V', 'mainfont:DejaVuSerif'
     , '-V', 'sansfont:DejaVuSans'
     , '-V', 'monofont:DejaVuSansMono'
]
pandoc_opts = {
    'pdf':_pandoc_latex_pdf,'latex':_pandoc_latex_pdf,
    'docx':[],'odt':[],
    'html':['--mathml','--highlight-style','pygments']
}

# usrstuff:
copyright = '2019, Roland Puntaier'

numfig = True

tikz_latex_preamble = r"""
\usepackage{unicode-math}
\usepackage{tikz}
"""
latex_elements = {
'preamble':tikz_latex_preamble+r"\usetikzlibrary{""" + tikz_tikzlibraries+ '}'
}

