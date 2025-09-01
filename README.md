# pyopengl-build

Build [PyOpenGL](https://github.com/mcfletch/pyopengl) wheels for Windows with [freeglut](https://github.com/freeglut/freeglut) and [GLE](https://sourceforge.net/projects/gle/) DLLs using [GitHub Actions](https://github.com/cgohlke/pyopengl-build/actions/workflows/wheel.yml).

The wheels can be downloaded from the [Releases](https://github.com/cgohlke/pyopengl-build/releases) page.

Install the wheels on the command line, for example for Python 3.14 64-bit:

    py.exe -3.14 -m pip install PyOpenGL-3.1.10-cp314-cp314-win_amd64.whl
    py.exe -3.14 -m pip install PyOpenGL_accelerate-3.1.10-cp314-cp314-win_amd64.whl
