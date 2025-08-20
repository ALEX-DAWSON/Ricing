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

if [ ! -d ~/$helper ]
then
    get &&
    build
else 
    update
fi