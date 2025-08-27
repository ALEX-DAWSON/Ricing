helper=paru

get() {
    cd &&
    git clone https://aur.archlinux.org/$helper.git
}

build() {
    cd $helper &&
    makepkg -si &&
    cd
}

update() {
    cd ~/$helper &&
    git pull &&
    makepkg -si &&
    cd
}

case $1 in
    depend)
        cd
        list=~/Ricing/aur-dependencies.txt

        $helper -S $list
    ;;
    *)
        if [ ! -d ~/$helper ]
        then
            get &&
            build
        else 
            update
        fi
    ;;
esac