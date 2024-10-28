:: Download PyOpenGL

@echo on
setlocal

:: set PYOPENGL_VER=release-3.1.8
set PYOPENGL_DIR=pyopengl-%PYOPENGL_VER%

curl -L -o %PYOPENGL_VER%.tar.gz https://github.com/mcfletch/pyopengl/archive/refs/tags/%PYOPENGL_VER%.tar.gz
if errorlevel 1 exit /B 1

tar -xf %PYOPENGL_VER%.tar.gz
if errorlevel 1 exit /B 1

:: https://stackoverflow.com/questions/24821431
git apply -p1 --verbose --directory=%PYOPENGL_DIR% pyopengl.diff
if errorlevel 1 exit /B 1

rd /S /Q %PYOPENGL_DIR%\.github
del %PYOPENGL_DIR%\.gitignore
del /S %PYOPENGL_DIR%\OpenGL\DLLS\*.dll
del /S %PYOPENGL_DIR%\accelerate\src\*.c

endlocal
