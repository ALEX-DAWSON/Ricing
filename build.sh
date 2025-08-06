#!/usr/bin/env bash

release_file=/etc/os-release

wallpaper_folder=~/Pictures/Wallpapers
sway_folder=~/.config/sway

this_wallpaper_folder=./Wallpapers
this_sway_folder=./sway

wallpaper () {
    if [ ! -d $wallpaper_folder ]
    then
        mkdir $wallpaper_folder &&
        cp ./Wallpapers/* $wallpaper_folder
        echo Copied wallpapers
    else
        echo There is already a wallpaper folder
    fi
}

sway() {
    if [ -n $(pacman -Q | grep "sway") ]
    then
        read -p "Do you want to install Sway? [y/N] : " input
        if [ $input = y ]
        then
            yes | sudo pacman -S sway
            mkdir $sway_folder
            cp $this_sway_folder/* $sway_folder
            echo Made directory $sway_folder and copied contents of $this_sway_folder to it
        else 
            :
        fi
    elif [ ! -d $sway_folder ]
    then
        mkdir $sway_folder
        cp $this_sway_folder/* $sway_folder
        echo Made directory $sway_folder and copied contents of $this_sway_folder to it
    else
        cp $this_sway_folder/* $sway_folder
        echo Copied contents of $this_sway_folder to $sway_folder
    fi
}

wallpaper && sway