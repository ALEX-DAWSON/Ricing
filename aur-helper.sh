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

depend() {
    cd
    list=~/Ricing/aur-dependencies.txt

    $helper -S $list
}
        

if [ ! -d ~/$helper ]
then
    get &&
    build &&
    depend
else 
    update
fi
