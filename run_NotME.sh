#!/bin/sh
cd ./bin
rm -rf notme.bin; echo $?
rm -rf notme.sym; echo $?
rm -rf notme.dsk; echo $?
rm -rf notme.sna; echo $?



echo "1 -> .dsk, 2 -> .sna"
read name
/Users/7511036v/Downloads/RASM/rasm.macos /Users/7511036V/Documents/Perso/ASM/DEV/NotME-AMSTRAD/notme.asm -void -sp -eo -sv -sl -v -o /Users/7511036V/Documents/Perso/ASM/DEV/NotME-AMSTRAD/bin/notme

idsk "notme.dsk" -i "/Users/7511036V/Documents/Perso/ASM/DEV/NotME-AMSTRAD/Data/notmescr.scr" -t 1
idsk "notme.dsk" -i "/Users/7511036V/Documents/Perso/ASM/DEV/NotME-AMSTRAD//notme.bas" -t 0

if [ "$name" = "1" ]; then
    cp -v "/Users/7511036V/Documents/Perso/ASM/DEV/NotME-AMSTRAD/bin/notme.dsk" "/Applications/AceDL.app/Contents/MacOS/media/dsk"
elif [ "$name" = "2" ]; then
    cp -v "/Users/7511036V/Documents/Perso/ASM/DEV/NotME-AMSTRAD/bin/notme.sna" "/Applications/AceDL.app/Contents/MacOS/media/snap"
else
    cp -v "/Users/7511036V/Documents/Perso/ASM/DEV/NotME-AMSTRAD/bin/notme.dsk" "/Applications/AceDL.app/Contents/MacOS/media/dsk"
fi

read -p "$*"
PROCESS=AceDL
number=$(ps aux | grep -v grep | grep -ci $PROCESS)

if [ $number -gt 0 ]
    then
        echo "l'emulateur est Running";
else
    echo Lancement de l emulateur
    cd /Applications/
    ls
    if [ "$name" = "1" ]; then
        /Applications/AceDL.app/Contents/MacOS/AceDL -autoRunFile 'notme.bas' /Applications/AceDL.app/Contents/MacOS/media/dsk/notme.dsk
    elif [ "$name" = "2" ]; then
        /Applications/AceDL.app/Contents/MacOS/AceDL /Applications/AceDL.app/Contents/MacOS/media/snap/notme.sna
    else
        /Applications/AceDL.app/Contents/MacOS/AceDL -autoRunFile 'notme.bas' /Applications/AceDL.app/Contents/MacOS/media/dsk/notme.dsk
    fi
fi
echo "emulateur ferme"
