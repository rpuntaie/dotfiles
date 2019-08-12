py3 << EOF
import uuid
from math import *
import sys
import time
import random

try:
  import numpy as np
  def iC():
      mt=int(time.time()-time.mktime((2017,12,31,24,0,0,0,0,0)))
      Id=''.join(list(reversed(np.base_repr(mt,36)))).lower()
      if Id[0] <= '9':
          Id = 'x'+Id
      vim.eval("setreg('i','%s')"%Id)
      return Id
  def iF():
      Idint=random.randint(0,36**2)
      Id=np.base_repr(Idint,36).lower()
      if len(Id)<2:
          Id='0'+Id
      _,nm = os.path.split(vim.current.buffer.name)
      for x in nm:
          if x!='_':
              Id = x.lower()+Id
              break
      vim.eval("setreg('i','%s')"%Id)
      return Id
except: pass

import locale
locale.setlocale(locale.LC_ALL, '')

try:
    from docutils.core import publish_string
    from rst2confluence import confluence
    def tojira():
      vim.current.range[:]=publish_string(
        vim_current_range()[0],writer=confluence.Writer()).splitlines()
except: pass
EOF
