get() {
    git clone https://aur.archlinux.org/yay.git
}

build() {
    cd yay &&
    makepkg -si &&
    cd
}

update() {
    cd yay &&
    git pull &&
    makepkg -si &&
    cd
}

if [ ! -d "~/yay" ]
then
    get &&
    build
else 
    update
fi