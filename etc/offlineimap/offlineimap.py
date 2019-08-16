#! /usr/bin/env python2
# -*- coding: utf-8 -*-

import subprocess
import logging
import os
import errno
from logging.handlers import RotatingFileHandler

def mkdir_p(path):
    try:
        os.makedirs(path)
    except OSError as exc:  # Python >2.5
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise

logger = logging.getLogger()
logger.setLevel(logging.DEBUG)
formatter = logging.Formatter('%(asctime)s :: %(levelname)s :: %(message)s')
log_file = os.path.join(os.getenv('XDG_CACHE_HOME'), 'offlineimap', 'get_pass.log')
path = os.path.dirname(log_file)
mkdir_p(path)
file_handler = RotatingFileHandler(log_file, 'a', 1000000, 1)
file_handler.setLevel(logging.DEBUG)
file_handler.setFormatter(formatter)
logger.addHandler(file_handler)

def get_pass(account):
    password_prg = "pass"
    cmd = "{} {}".format(password_prg, account)
    try:
        output = subprocess.check_output(cmd, shell=True).splitlines()[0]
    except subprocess.CalledProcessError as e:
        logger.exception("cmd: {} : failed".format(cmd))
        return ""
    else:
        logger.info("cmd: {} : succeed".format(cmd))
        return output.splitlines()[0]
