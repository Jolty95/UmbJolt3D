@echo off

echo Script de compilacion de UmbJolt3D por Jolty95
echo =======================================
echo Versión: 1.0
echo Proyecto: UmbJolt3D por Jolty95 & Esky73
echo =======================================
if "%1" == "clean" goto clean
echo Borrando el directorio romfs....
del Builder\romfs\index.lua
echo Copiando el script actualizado al directorio romfs...
::Copia el nuevo índice a romsfs
mkdir Builder\romfs
copy index.lua Builder\romfs\index.lua
echo Compilando romfs en el directorio...
cd Builder
tools\3dstool -cvtf romfs romfs.bin --romfs-dir romfs
::Si no hay parametros, compila todo. Si hay compila cia o 3dsx.
if "%1" == "" goto all
if %1 == cia-b goto cia
if %1 == 3dsx-b goto 3dsx

goto %1

:all
echo Compilando en formato cia y 3dsx...
call :cia-b
call :3dsx-b
echo Compilación terminada.
cd ..
exit /b

:3dsx
echo Compilando en formato 3dsx...
call :3dsx-b
echo Compilación terminada.
cd ..
exit /b
:cia
echo Compilando en formato cia...
call :cia-b
echo Compilación terminada.
cd ..
exit /b

:3dsx-b
echo Creando información SMDH...
tools\bannertool makesmdh -s "UmbJolt3D" -l "La creación de Jolty y Esky" -p "Jolty95 & Esky73" -i UmbJolt3DLogo.png -o UmbJolt3D.smdh
echo Creando archivo 3DSX...
tools\3dsxtool bin/lpp-3ds.elf ../UmbJolt3D.3dsx --romfs=romfs.bin --smdh=UmbJolt3D.smdh
goto :EOF

:cia-b
echo Creando banner desde los archivos...
tools\bannertool makebanner -i banner.png -a sonido.wav -o banner.bin
echo Creando icono desde archivo...
tools\bannertool makesmdh -s "UmbJolt3D" -l "La creación de Jolty y Esky" -p "Jolty95 & Esky73" -i UmbJolt3DLogo.png -o icono.bin
echo Creando archivo CIA ...
::RSF mas adelante
::tools\makerom -f cia -o ../UmbJolt3D.cia -elf bin/lpp-3ds.elf -rsf UmbJolt3D.rsf -icon icon.bin -banner banner.bin -exefslogo -target t -romfs romfs.bin
tools\makerom -f cia -o ../UmbJolt3D.cia -elf bin/lpp-3ds.elf -icon icon.bin -banner banner.bin -exefslogo -target t -romfs romfs.bin
goto :EOF

:clean
echo Limpiando...
cd Builder
del ..\*.3dsx
del ..\*.cia
del romfs\*.lua
del *.bin
del *.smdh
cd ..
echo Operación terminada.
exit /b