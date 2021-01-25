# -*- coding: utf-8 -*-

#sphinx config file used in ../bin/sphinxbuild1

# Deprecation
# The sphinxcontrib packages lag behind sphinx.
# I use rstdoc now, which keeps tikz and the like in separate files.

# pip install --user git+https://bitbucket.org/philexander/tikz/src/master/
# pip install --user git+https://github.com/prometheusresearch/sphinxcontrib-texfigure
# pip install --user git+https://github.com/rpuntaie/sphinxcontrib-thm

import re,os.path

extensions = ['sphinx.ext.todo',
'sphinx.ext.autodoc',
'sphinx.ext.napoleon',
'sphinx.ext.mathjax',
'sphinxcontrib.tikz',
'sphinxcontrib.texfigure',
'sphinxcontrib.thm']
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

# usrstuff:
copyright = '2019, Roland Puntaier'

thm_use_environment = True
thm_use_textcolor = True
thm_use_align = True
#thm_no_displayname = True #default is False
numfig = True
#envname, displayname, counter=None
thm_theorems = [
    ('theorem','Theorem','theorem'),
    ('lemma','Lemma','lemma'),
    ('corollary','Corollary','corollary'),
    ('proposition','Proposition','proposition'),
    ('conjecture','Conjecture','conjecture'),
    ('criterion','Criterion','criterion'),
    ('assertion','Assertion','assertion'),
    ('definition','Definition','definition'),
    ('condition','Condition','condition'),
    ('problem','Problem','problem'),
    ('example','Example','example'),
    ('exercise','Exercise','exercise'),
    ('algorithm','Algorithm','algorithm'),
    ('question','Question','question'),
    ('axiom','Axiom','axiom'),
    ('property','Property','property'),
    ('assumption','Assumption','assumption'),
    ('hypothesis','Hypothesis','hypothesis'),
    ('remark','Remark','remark'),
    ('notation','Notation','notation'),
    ('claim','Claim','claim'),
    ('summary','Summary','summary'),
    ('acknowledgment','Acknowledgment','acknowledgment'),
    ('case','Case','case'),
    ('conclusion','Conclusion','conclusion'),
    ('proof','Proof')
]


tikz_latex_preamble = r"""
%preamble for sphinxcontrib-thm
\usepackage{unicode-math}
\usepackage{amsthm}%\usepackage{ntheorem} works too
\usepackage{siunitx}
\usepackage{tikz}
\usepackage{tikz-uml}
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}
\newtheorem{lemma}{Lemma}
\newtheorem{corollary}{Corollary}
\newtheorem{proposition}{Proposition}
\newtheorem{conjecture}{Conjecture}
\newtheorem{criterion}{Criterion}
\newtheorem{assertion}{Assertion}
\theoremstyle{definition}
\newtheorem{definition}{Definition}
\newtheorem{condition}{Condition}
\newtheorem{problem}{Problem}
\newtheorem{example}{Example}
\newtheorem{exercise}{Exercise}
\newtheorem{algorithm}{Algorithm}
\newtheorem{question}{Question}
\newtheorem{axiom}{Axiom}
\newtheorem{property}{Property}
\newtheorem{assumption}{Assumption}
\newtheorem{hypothesis}{Hypothesis}
\theoremstyle{remark}
\newtheorem{remark}{Remark}
\newtheorem{notation}{Notation}
\newtheorem{claim}{Claim}
\newtheorem{summary}{Summary}
\newtheorem{acknowledgment}{Acknowledgment}
\newtheorem{case}{Case}
\newtheorem{conclusion}{Conclusion}
\newtheorem{instruction}{Instruction}%because we used .. environment:: instruction
%\newtheorem{proof}{Proof} for ntheorem
"""
latex_elements = {
'preamble':tikz_latex_preamble+r"\usetikzlibrary{""" + tikz_tikzlibraries+ '}'
}

thmstyle="""
div.thm_caption{
    padding-top: 0.3ex;
    font-weight: bold;
}
span.thm_counter{
    padding-left: 4px;
}
span.thm_title{
    font-weight: bold;
    font-style: italic;
}
div.thm_body{
    padding-left: 1em;
}
div.instruction::before{
    content:"Instruction:";
    font-weight: bold;
}
div.instruction_title{
    font-weight: bold;
    font-style: italic;
}
div.instruction_body{
    padding-left: 1em;
}
p.flushleft{
    text-align: left;
}
p.flushright{
    text-align: right;
}
p.center{
    text-align: center;
}
"""

