#!/usr/bin/env bash

release_file=/etc/os-release

wallpaper_folder=~/Pictures/Wallpapers
sway_folder=~/.config/sway
hypr_folder=~/.config/hypr
waybar_folder=~/.config/waybar

this_wallpaper_folder=./Wallpapers
this_sway_folder=./sway
this_hypr_folder=./hyprland
this_waybar_folder=./waybar

wallpaper () {
    if [ ! -d $wallpaper_folder ]
    then
        mkdir $wallpaper_folder &&
        cp ./Wallpapers/* $wallpaper_folder
        echo Made $wallpaper_folder and copied Wallpapers
    else
	cp ./Wallpapers/* $wallpaper_folder
        echo Copied Wallpapers
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
            yes | sudo pacman -S hyprland waybar hyprpaper
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

waybar() {
	if [ ! -d $waybar_folder ]
	then
		mkdir $waybar_folder
		cp $this_waybar_folder/* $waybar_folder
		echo Made $waybar_folder and copied $this_waybar_folder
	else
		cp $this_waybar_folder/* $waybar_folder
		echo Copied $this_waybar_folder to $waybar_folder
	fi
}

wallpaper && hypr && waybar
