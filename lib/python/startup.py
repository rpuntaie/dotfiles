#!/usr/bin/env python3

"""
echo $PYTHONSTARTUP
startup.py is run at the startup of each interactive python and from vim

pip_install
sv to shelve
p/"path/to/file" to get a Path object
pprint pp/opj ll/obj
VENV TDIR
fake.email(10)
null true false #json
self

ap argparse
ut unittest
dt datetime
pm pendulum
np numpy
pd pandas
sp scipy

"""

import sys
import os
import atexit

########################### options
try:
    from IPython import get_ipython
    sys.path.append('/usr/lib/python3.11/site-packages')
    ipython = get_ipython()
    if ipython:
        # ipython.run_line_magic("doctest_mode", "")
        ipython.run_line_magic("load_ext", "ipython_autoimport")
    # Force jupyter to print any lone variable, not just the last one in a cell
    from IPython.core.interactiveshell import InteractiveShell
    InteractiveShell.ast_node_interactivity = "all"
except ImportError:
    pass
try:
    import readline
    readline.parse_and_bind("tab: complete")
    python_history = os.environ.get('XDG_STATE_HOME')+'/python_history'
    if os.path.exists(python_history):
        readline.read_history_file(python_history)
    atexit.unregister(readline.write_history_file)
    atexit.register(readline.write_history_file, python_history)
except ImportError:
    pass
########################### options

import uuid
import csv
import hashlib
import json
import math
import random
import re
import shelve
import subprocess
import tempfile
import argparse as ap
import unittest as ut
import datetime as dt
import asyncio
from typing import *
from dataclasses import dataclass, field
from collections import *
from functools import partial
from inspect import getmembers, ismethod, stack
import io # StringIO, BytesIO
from itertools import *
from math import *
from datetime import datetime, date, timedelta

try:
    import pendulum as pm
except ImportError:
    pass

try:
    import requests
except ImportError:
    pass

try:
    from rich import pretty
    pretty.install()
except ImportError:
    pass

# p/"path/to/file" to get a Path object
from pathlib import Path
try:
    class PathLiteral:
        def __truediv__(self, other):
            try:
                return Path(other.format(**stack()[1][0].f_globals))
            except KeyError as e:
                raise NameError("name {e} is not defined".format(e=e))
        def __call__(self, string):
            return self / string
    p = PathLiteral()
except ImportError:
    pass

VENV = os.environ.get("VIRTUAL_ENV")
TDIR = Path(tempfile.gettempdir()) / "pythontemp"

try:
    os.makedirs(TDIR)
except Exception:
    pass

# sv.foo = 'bar' and get sv.foo in the next session
class Sv(object):
    def __init__(self, filename):
        object.__setattr__(self, "DICT", shelve.open(filename))
        atexit.register(self._clean)
    def __getattribute__(self, name):
        if name not in ("DICT", "_clean"):
            try:
                return self.DICT[name]
            except:
                return None
        return object.__getattribute__(self, name)
    def __setattr__(self, name, value):
        if name in ("DICT", "_clean"):
            raise ValueError("'%s' is a reserved name for this Sv" % name)
        self.DICT[name] = value
    def _clean(self):
        self.DICT.sync()
        self.DICT.close()
try:
    sv = Sv(os.path.join(TDIR, "tmp.py.db"))
except:
    pass

# pprint pp ll
def is_public_attribute(obj, name, methods=()):
    return not name.startswith("_") and name not in methods and hasattr(obj, name)
def attributes(obj):
    members = getmembers(type(obj))
    methods = {name for name, val in members if callable(val)}
    is_allowed = partial(is_public_attribute, methods=methods)
    return {name: getattr(obj, name) for name in dir(obj) if is_allowed(obj, name)}
STDLIB_COLLECTIONS = (
    str,
    bytes,
    int,
    float,
    complex,
    memoryview,
    dict,
    tuple,
    set,
    bool,
    bytearray,
    frozenset,
    slice,
    deque,
    defaultdict,
    OrderedDict,
    Counter,
)
try:
    from rich.pretty import print as pprint
except ImportError:
    from pprint import pprint as pretty_print
    def pprint(obj):
        if isinstance(obj, STDLIB_COLLECTIONS):
            pretty_print(obj)
        else:
            try:
                name = "class " + obj.__name__
            except AttributeError:
                name = obj.__class__.__name__ + "()"
            class_name = obj.__class__.__name__
            print(name + ":")
            attrs = attributes(obj)
            if not attrs:
                print("    <No attributes>")
            for name, val in attributes(obj).items():
                print("   ", name, "=", val)
# pp/obj work as a postfix operator as well
class Printer(float):
    def __call__(self, *args, **kwargs):
        pprint(*args, **kwargs)
    def __truediv__(self, other):
        pprint(other)
    def __rtruediv__(self, other):
        pprint(other)
    def __repr__(self):
        return repr(pprint)
pp = Printer()
pp.__doc__ = pprint.__doc__
class ToList(list):
    def __truediv__(self, other):
        return list(other)
    def __rtruediv__(self, other):
        return list(other)
    def __call__(self, *args, **kwargs):
        return list(*args, **kwargs)
ll = ToList()

# to generate fake data, eg fake.email(10)
try:
    import faker
except ImportError:
    pass
else:
    from faker.providers import internet, geo
    def get_faker(locale="en"):
        fake = faker.Faker(locale)
        fake.add_provider(internet)
        fake.add_provider(geo)
        return fake
    class Fake(object):
        factory = get_faker()
        @property
        def fr(self):
            self.factory = get_faker("it_IT")
            return self
        @property
        def fr(self):
            self.factory = get_faker("de_DE")
            return self
        @property
        def fr(self):
            self.factory = get_faker("ru_RU")
            return self
        @property
        def fr(self):
            self.factory = get_faker("es_ES")
            return self
        @property
        def fr(self):
            self.factory = get_faker("fr_FR")
            return self
        @property
        def en(self):
            self.factory = get_faker()
            return self
        def __getattr__(self, name):
            faker_provider = self.factory.__getattr__(name)
            return lambda count=1: self.call_faker(faker_provider, count)
        def __dir__(self):
            attrs = [
                attr for factory in fake.factory._factories for attr in dir(factory)
            ]
            return ["it", "de", "ru", "es", "fr", "en", *attrs]
        def call_faker(self, faker_provider, count=1):
            if count == 1:
                return faker_provider()
            else:
                return [faker_provider() for _ in range(count)]
    fake = Fake()


try:
    import numpy as np
except ImportError:
    pass
try:
    import pandas as pd
except ImportError:
    pass
try:
    import scipy as sp
except ImportError:
    pass

# alias that make JSON valid Python syntax
null = None
true = True
false = False

#useful when executing line-wise
class self:
    pass

try:
    import vim
    sys.path.append(os.path.expanduser('~/msrc/blender-git/build_linux_bpy/bin'))
except ImportError:
    pass

