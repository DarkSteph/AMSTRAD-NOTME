#!/bin/sh
date=$(date '+%Y%m%d')
cd ./bin
rm -rf notme_$date.bin; echo $?
rm -rf notme_$date.sym; echo $?
rm -rf notme_$date.dsk; echo $?
rm -rf notme_$date.sna; echo $?



echo $date
echo "1 -> .dsk, 2 -> .sna"
read name
/Users/7511036v/Downloads/RASM/rasm.macos /Users/7511036V/Documents/Perso/ASM/DEV/AMSTRAD-NOTME/notme_compress.asm -void -sp -eo -sv -sl -v -o /Users/7511036V/Documents/Perso/ASM/DEV/AMSTRAD-NOTME/bin/notme

idsk "notme.dsk" -i "/Users/7511036V/Documents/Perso/ASM/DEV/AMSTRAD-NOTME/Data/notmescr.scr" -t 1
idsk "notme.dsk" -i "/Users/7511036V/Documents/Perso/ASM/DEV/AMSTRAD-NOTME//notme.bas" -t 0

#Rename dsk
mv notme.dsk notme_$date.dsk

if [ "$name" = "1" ]; then
    cp -v "/Users/7511036V/Documents/Perso/ASM/DEV/AMSTRAD-NOTME/bin/notme_$date.dsk" "/Applications/AceDL.app/Contents/MacOS/media/dsk"
elif [ "$name" = "2" ]; then
    cp -v "/Users/7511036V/Documents/Perso/ASM/DEV/AMSTRAD-NOTME/bin/notme_$date.sna" "/Applications/AceDL.app/Contents/MacOS/media/snap"
else
    cp -v "/Users/7511036V/Documents/Perso/ASM/DEV/AMSTRAD-NOTME/bin/notme_$date.dsk" "/Applications/AceDL.app/Contents/MacOS/media/dsk"
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
        /Applications/AceDL.app/Contents/MacOS/AceDL -autoRunFile 'notme.bas' /Applications/AceDL.app/Contents/MacOS/media/dsk/notme_$date.dsk
    elif [ "$name" = "2" ]; then
        /Applications/AceDL.app/Contents/MacOS/AceDL /Applications/AceDL.app/Contents/MacOS/media/snap/notme_$date.sna
    else
        /Applications/AceDL.app/Contents/MacOS/AceDL -autoRunFile 'notme.bas' /Applications/AceDL.app/Contents/MacOS/media/dsk/notme_$date.dsk
    fi
fi
echo "emulateur ferme"
