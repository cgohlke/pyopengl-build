:: Download and build FreeGLUT and GLE
:: Requires download.cmd run before

@echo on
setlocal

:: set PYOPENGL_VER=3.1.10
:: set FREEGLUT_VER=v3.6.0
:: set GLE_VER=3.1.0

set PYOPENGL_DIR=pyopengl-%PYOPENGL_VER%
set FREEGLUT_DIR=freeglut-%FREEGLUT_VER%
set GLE_DIR=gle-%GLE_VER%

:: GLE32
setlocal

curl -L -o gle-%GLE_VER%.tar.gz https://sourceforge.net/projects/gle/files/gle/gle-%GLE_VER%/gle-%GLE_VER%.tar.gz
if errorlevel 1 exit /B 1

tar -xf gle-%GLE_VER%.tar.gz
if errorlevel 1 exit /B 1

git apply -p1 --verbose --directory=%GLE_DIR% gle.diff
if errorlevel 1 exit /B 1

cd %GLE_DIR%\src

cl.exe -I. -I.. ^
    ex_alpha.c     ^
    ex_angle.c     ^
    ex_cut_round.c ^
    ex_raw.c       ^
    extrude.c      ^
    intersect.c    ^
    qmesh.c        ^
    rot_prince.c   ^
    rotate.c       ^
    round_cap.c    ^
    segment.c      ^
    texgen.c       ^
    urotate.c      ^
    view.c         ^
    /D WIN32 /D NDEBUG /D _WINDOWS /D _USRDLL /D _WINDLL /D _UNICODE /D UNICODE ^
    /link /DLL /DEF:..\gle.def /IMPLIB:gle32.lib /out:gle32.dll glu32.lib opengl32.lib
if errorlevel 1 exit /B 1

copy /Y /B gle32.dll ..\..\%PYOPENGL_DIR%\OpenGL\DLLS\gle32.dll
if errorlevel 1 echo Build failed! && exit /B 1

cd ..
cd ..

endlocal

:: FreeGLUT
setlocal

set CMAKE_GENERATOR=NMake Makefiles
set CMAKE_BUILD_TYPE=Release
set CMAKE_CONFIGURATION_TYPES=Release
set CMAKE_SKIP_RPATH=ON
set CMAKE_VERBOSE_MAKEFILE=ON
set CMAKE_RULE_MESSAGES=OFF
set CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP=ON

git.exe clone -c advice.detachedHead=false --depth 1 --recurse-submodules --branch %FREEGLUT_VER% https://github.com/FreeGLUTProject/freeglut %FREEGLUT_DIR%
if errorlevel 1 exit /B 1

:: git apply -p1 --verbose --directory=%FREEGLUT_DIR% freeglut.diff
:: if errorlevel 1 exit /B 1

cd %FREEGLUT_DIR%

cmake.exe -DCMAKE_INSTALL_PREFIX=_release
if errorlevel 1 exit /B 1

nmake.exe /nologo all
if errorlevel 1 exit /B 1

nmake.exe /nologo install
if errorlevel 1 exit /B 1

copy /B _release\bin\*.dll ..\%PYOPENGL_DIR%\OpenGL\DLLS\
if errorlevel 1 exit /B 1

cd ..

endlocal

endlocal
