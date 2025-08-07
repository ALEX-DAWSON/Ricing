#!/usr/bin/env bash

release_file=/etc/os-release

wallpaper_folder=~/Pictures/Wallpapers
sway_folder=~/.config/sway
hypr_folder=~/.config/hypr

this_wallpaper_folder=./Wallpapers
this_sway_folder=./sway
this_hypr_folder=./hyprland

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

hypr() {
    if [ -n $(pacman -Q | grep "hyprland") ]
    then
        read -p "Do you want to install hyprland? [y/N] : " input
        if [ $input = y ]
        then
            yes | sudo pacman -S hyprland
            mkdir $hypr_folder
            cp $this_hypr_folder/* $hypr_folder
            echo Made directory $hypr_folder and copied contents of $this_hypr_folder to it
        else 
            :
        fi
    elif [ ! -d $hypr_folder ]
    then
        mkdir $hypr_folder
        cp $this_hypr_folder/* $hypr_folder
        echo Made directory $hypr_folder and copied contents of $this_hypr_folder to it
    else
        cp $this_hypr_folder/* $hypr_folder
        echo Copied contents of $this_hypr_folder to $hypr_folder
    fi
}

wallpaper && hypr