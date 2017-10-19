## Install Pypy on Ubuntu 17.10

Pypy is a jit-compiler for Python

The Pypy that's in the Ubuntu repository only has a limited number
of additional libraries that can be installed, and libraries that
are installed for the system Cpython are not easily made to work
with Pypy. For these reasons, it's best to get Pypy from the
Pypy website and use PIP to install libraries from PyPI.

According to the official Pypy website http://pypy.org/download.html ,
it's most convenient to install the
"Portable PyPy distribution for Linux" from:

[https://github.com/squeaky-pl/portable-pypy](https://github.com/squeaky-pl/portable-pypy#portable-pypy-distribution-for-linux)

Scroll the page to look for the header "Latest Python **2.7** release"
Download the latest Python **2.7** tarfile from there
(x86_64 only, I'm afraid). (The 3.5 version is still
in beta, and my code is still 2.7-compatible for that reason.)

Create a suitable Pypy application directory and extract the tarfile into it:

$ tar -xjf pypy-*-portable.tar.bz2

Create virtual environment:

$ ./pypy-*-portable/bin/virtualenv-pypy myenv

Create links for pypy and pypy-pip such that pypy-pip will install
PyPI libraries into that virtual environment. pypy-pip can then be
safely run from any directory:

$ cd myenv/bin
$ sudo ln -s "$PWD/pypy" /usr/local/bin/pypy
$ sudo ln -s "$PWD/pip" /usr/local/bin/pypy-pip

Install Numpy into the virtual environment:

$ pypy-pip install numpy

Install system packages needed for pillow image library:

$ sudo apt-get install libfreetype6-dev libjpeg-dev libpng12-dev

Install pillow image library

NOTE: If not all dependencies installed, pillow will still compile but
with disabled functions such as jpeg or png handling.

$ pypy-pip install pillow




