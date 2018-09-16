#!/bin/sh

updates=0
if [ -n "$(which yay 2> /dev/null)" ]; then
    updates=$(yay -Qu --quiet | wc -l)
else
    updates_arch=0
    if [ -n "$(which checkupdates 2> /dev/null)" ]; then
        updates_arch=$(checkupdates | wc -l)
    else
        updates_arch=$(pacman -Qu --quiet | wc -l)
    fi

    updates_aur=0
    if [ -n "$(which trizen 2> /dev/null)" ]; then
        if ! updates_aur=$(trizen -Su --aur --quiet | wc -l); then
            updates_aur=0
        fi
    elif [ -n "$(which cower 2> /dev/null)" ]; then
        if ! updates_aur=$(cower -u 2> /dev/null | wc -l); then
            updates_aur=0
        fi
    fi

    updates=$(("$updates_arch" + "$updates_aur"))
fi

if [ "$updates" -gt 0 ]; then
    echo "# $updates"
else
    echo ""
fi
