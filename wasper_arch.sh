#!/usr/bin/env bash
# Install script for Arch Linux
# autor: Alex Creio https://cvc.hashbase.io/

# https://raw.githubusercontent.com/creio/dots/master/.bin/creio.sh

# wget https://github.com/wasper77/Linux/edit/master/wasper_arch.sh
# nano wasper_arch.sh
# sh wasper_arch.sh

Check for root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root." >&2
   echo "Try 'sudo sh'"
   echo ""
   exit 1
fi


B_DISK="sda1"
R_DISK="sda2"
H_DISK="sda3"
S_DISK="sda4"

loadkeys ru
setfont cyr-sun16

timedatectl set-ntp true

mkfs.ext2 /dev/$B_DISK -L boot
# mkfs.fat -F32 /dev/$B_DISK -L boot

mkfs.ext4 /dev/$R_DISK -L root

mkfs.ext4 /dev/$H_DISK -L home
mkswap /dev/$S_DISK -L swap

mount /dev/$R_DISK /mnt

mkdir /mnt/{boot,home}
# mkdir -p /mnt/{boot/efi,home}

mount /dev/$B_DISK /mnt/boot
# mount /dev/$B_DISK /mnt/boot/efi


mount /dev/$H_DISK /mnt/home
swapon /dev/$S_DISK

# pacman -Sy --noconfirm --needed reflector
# reflector -c "Russia" -c "Belarus" -c "Ukraine" -c "Poland" -f 20 -l 20 -p https -p http -n 20 --save /etc/pacman.d/mirrorlist --sort rate

pacstrap /mnt base base-devel

# cp creio2.sh /mnt/creio2.sh
# chmod u+x /mnt/creio2.sh

genfstab -pU /mnt >> /mnt/etc/fstab

# arch-chroot /mnt sh -c "$(curl -fsSL git.io/creio2.sh)"
arch-chroot /mnt ./creio2.sh





#!/usr/bin/env bash
# Install script for Arch Linux
# autor: Alex Creio https://cvc.hashbase.io/

# https://raw.githubusercontent.com/creio/dots/master/.bin/creio2.sh

# wget git.io/creio2.sh
# nano creio2.sh




# CREIO2.SH  _________________________________________

DISK="sda"


sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

pacman -Sy --noconfirm --needed reflector
reflector -c "Russia" -c "Belarus" -c "Ukraine" -c "Poland" -f 20 -l 20 -p https -p http -n 20 --save /etc/pacman.d/mirrorlist --sort rate


echo "Arch Linux Virtualbox?"
read -p "yes, no: " virtualbox_setting
if [[ $virtualbox_setting == no ]]; then
  virtualbox_install=""
elif [[ $virtualbox_setting == yes ]]; then
  virtualbox_install="virtualbox-guest-modules-arch virtualbox-guest-utils"
fi
echo
pacman -S --noconfirm --needed $virtualbox_install


pack="xorg-apps xorg-server xorg-xinit \
mesa xf86-video-nouveau \
networkmanager network-manager-applet \
gtk-engines gtk-engine-murrine xdg-user-dirs-gtk qt4 qt5-styleplugins qt5ct \
arc-gtk-theme papirus-icon-theme \
ttf-dejavu ttf-hack ttf-roboto ttf-ubuntu-font-family ttf-font-awesome \
alsa-utils gstreamer pulseaudio pulseaudio-alsa \
ffmpeg mpc mpd mpv ncmpcpp streamlink youtube-dl youtube-viewer rofi \
bash-completion gtk2-perl rxvt-unicode urxvt-perls slop wmctrl zsh zsh-syntax-highlighting \
dunst reflector ranger htop scrot imagemagick compton w3m \
openssh tmux \
curl wget git rsync python-pip unzip unrar p7zip \
gvfs gvfs-afc gvfs-goa gvfs-mtp ntfs-3g \
gamin thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman tumbler \
gsimplecal redshift numlockx volumeicon \
atril audacious cherrytree galculator-gtk2 gimp gparted firefox firefox-i18n-ru \
gufw nitrogen pavucontrol simplescreenrecorder transmission-gtk viewnior keepassxc veracrypt \
exo garcon gtk-xfce-engine xfce4-power-manager xfce4-session xfce4-settings xfconf xfdesktop xfwm4"

pacman -S --noconfirm --needed $pack


# Root password
passwd


# user add & password
while true; do
    clear
    echo -e "\nWhat would you like your username to be?
    \n\nDo NOT pick the name of an already existing user. This will overwrite their files!"

    printf "\n\nUsername: "
    read -r USER

    printf "You chose %s for your name. Wanna continue? [y/N]: " "$USER"
    read -r answer

    case $answer in
        y*|Y*) break
    esac
done

useradd -m -g users -G "adm,audio,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/zsh "$USER"
passwd "$USER"
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers


echo "ctlos" > /etc/hostname

ln -svf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen


echo "LANG=ru_RU.UTF-8" > /etc/locale.conf
echo "KEYMAP=ru" >> /etc/vconsole.conf
echo "FONT=cyr-sun16" >> /etc/vconsole.conf

mkinitcpio -p linux

pacman -S --noconfirm --needed grub
# pacman -S --noconfirm --needed grub efibootmgr

grub-install /dev/$DISK
# grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch --force

grub-mkconfig -o /boot/grub/grub.cfg


systemctl enable NetworkManager
# systemctl enable lightdm

echo "System Setup Complete"
