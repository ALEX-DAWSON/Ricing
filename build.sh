#!/usr/bin/env bash

release_file=/etc/os-release

wallpaper_folder=~/Pictures/Wallpapers
hypr_folder=~/.config/hypr
waybar_folder=~/.config/waybar
wofi_folder=~/.config/wofi

this_wallpaper_folder=./Wallpapers
this_hypr_folder=./hyprland
this_waybar_folder=./waybar
this_wofi_folder=./wofi


login() {
    read -p "What is your current login manager? [ENTER = gdm]: " old_login_manager 
    if [ "$old_login_manager" == "" ]
    then
        old_login_manager=gdm
    fi
    echo "You selected $old_login_manager" &&
    sleep 1 &&
    read -p "What do you want your new login manager to be? [ENTER = ly]: " new_login_manager 
    if [ "$new_login_manager" == "" ]
    then
        new_login_manager=ly
    fi
    echo "You selected $new_login_manager" &&
    sleep 1 &&
    read -p "Are you sure you want to replace $old_login_manager with $new_login_manager? [y/N]: " input
    case $input in
        "y" | "Y" |"yes" | "Yes" | "YES")
            echo "Installing $new_login_manager. Input your password once prompted. Please don't close this terminal until I'm done pls. Thx" &&
            sleep 3 &&
            sudo pacman -S $new_login_manager &&
            sudo systemctl disable $old_login_manager &&
            sudo systemctl enable $new_login_manager
        ;;
        *) 
            echo "Aight, Fam. We're good. No changes were made."
            return
        ;;
    esac
}

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

hypr() {
    if [ ! -d $hypr_folder ]
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

wofi() {
    if [ ! -d $wofi_folder ]
	then
		mkdir $wofi_folder
		cp $this_wofi_folder/* $wofi_folder
		echo Made $wofi_folder and copied $this_wofi_folder
	else
		cp $this_wofi_folder/* $wofi_folder
		echo Copied $this_wofi_folder to $wofi_folder
	fi
}

install() {
    cd &&
    if [ ! -d ~/dotfiles ]
	then
        git clone https://github.com/ALEX-DAWSON/dotfiles.git
	fi
    cd dotfiles &&
    if [ ! -d ~/.config ]
	then
		mkdir ~/.config
	fi
    bash build all &&
    cd &&
    yes | sudo pacman -S - < ~/Ricing/dependencies.txt &&
    read -p "What login manager will you use? [Enter = ly]: " login_manager
    if [ "$login_manager" == "" ]
    then
        login_manager=ly
    fi
    yes | sudo pacman -S $login_manager &&
    sudo systemctl enable $login_manager
    return
}

case $1 in
    login) 
        login 
    ;;
    aur)
        bash aur-helper.sh
    ;;
    install)
        install &&
        wallpaper && 
        hypr && 
        waybar &&
        wofi
    ;; 
    *) 
        wallpaper && 
        hypr && 
        waybar &&
        wofi
    ;;
esac
