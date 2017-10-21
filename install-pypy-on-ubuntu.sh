#!/bin/bash

# Install PyPy and support packages needed for installing PiPI modules

sudo apt-get update
sudo apt-get install pypy pypy-dev pypy-setuptools virtualenv

# Packages like tkinter can not be installed from PiPI because they
# need to be compiled against the OS, but tkinter is in the OS repository

sudo apt-get install pypy-tk

# The pypy-setuptools package had easy_install-pypy which can install
# modules from PiPI but is considered inferior to pip. Get pip.
# It will be installed in /usr/local/lib/pypy2.7/dist-packages/
# Just delete it from there if you want to uninstall it
# Unlike easy_install-pypy, pip itself can uninstall modules cleanly
# The '-x' option prevents links from being placed in /usr/local/bin
# which could clash with the system Cpython.

sudo easy_install-pypy -x pip

# When you run pip, you run arbitrary Python code from the PiPI
# repository, therefore it is frowned upon to run pip with sudo.
# Create a user-writable directory for modules installed with pip.
# The /opt directory is for user-installed application packages

sudo mkdir -p /opt/pypy2.7
sudo chmod a+rwx /opt/pypy2.7

# Now create an environment directory for pypy

virtualenv -p /usr/bin/pypy /opt/pypy2.7/env

# Link pypy and pypy-pip from that environment to /usr/local/bin
# Python modules can then be installed as user with "pypy-pip" from
# any directory.

sudo ln -s /opt/pypy2.7/env/bin/pip /usr/local/bin/pypy-pip
sudo ln -s /opt/pypy2.7/env/bin/pypy /usr/local/bin/pypy

# Install numpy with pip

pypy-pip install numpy

# Install packages depended upon by "pillow" image library
# If not all dependencies installed, pillow will still compile but
# with disabled functions such as jpeg or png handling

sudo apt-get install libfreetype6-dev libjpeg-dev libpng12-dev

# Install pillow -- fork of PIL, Python Image Library
# --no-cache-dir ensures that it is recompiled if re-downloaded

pypy-pip install --ignore-installed --no-cache-dir --verbose pillow

# It is advisable to scroll back 100 lines to look for PIL SETUP SUMMARY
# to check that all is well with it
# to uninstall if necessary -- pypy-pip uninstall pillow

