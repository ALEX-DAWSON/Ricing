get() {
    cd &&
    git clone https://aur.archlinux.org/paru.git
}

build() {
    cd paru &&
    makepkg -si &&
    cd
}

update() {
    cd paru &&
    git pull &&
    makepkg -si &&
    cd
}

if [ ! -d "~/paru" ]
then
    get &&
    build
else 
    update
fi