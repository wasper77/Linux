Чек лист по установке и настройке Arch Linux Xfce


###########################################################################

ЕСТЬ ВОПРОСЫ? 
ВСТУПАЙ В ГРУППУ ПО ARCH LINUX 
И ПОЛУЧИ БЕСПЛАТНУЮ ПОДДЕРЖКУ
https://vk.com/arch4u 
ПИШИ В НАШ LINUX CHAT
https://vk.me/join/AJQ1d87K9gAjXk7b0PeTtiJT 

###########################################################################

Подпишись на Linux канал: https://www.youtube.com/arch4u 
Вы можете помочь и поддержать автора!
Яндекс деньги: https://yasobe.ru/na/linux4all 
PayPal: https://www.paypal.me/ordanax 
Яндекс кошелек: 410011742905486
WebMoney: R823965535328
##################################
https://vk.cc/7S7LO5  - Ручная установка Arch Linux
https://vk.cc/7S7LCV  - Установка Arch Linux Xfce от А до Я июнь 2017
https://vk.cc/7S7LeJ  - Установка Arch Linux с удаленного компьютера 
Как подключиться по SSH смотрите здесь https://vk.cc/78fmtH 
https://vk.cc/7S7KCf  - XFCE. Настройка после установки (Arch Linux)

##################################

Трудности? Вопросы? Пишите в группу по Arch Linux https://vk.com/arch4u 

##############################################

Актуальность установки проверяйте на англоязычной Wiki https://vk.cc/5NRgaB
Дополнительные настройки и любые изменения к чек листу буду вносить именно здесь и нигде в другом месте!

##############################################

Если при установке Arch Linux у кого-то нет второго телефона или компа, то можно прям на этом же компе набрать команду less install.txt и вы получите актуальную версию установки Arch Linux (Копию Arch Wiki на англ.)
Окно можно не закрывать и открыть второй терминал сочетанием клавиш Alt+F2 для установки Arch Linux и вернуться к Arch Wiki можно сочетанием клавиш Alt+F1.

##############################################

Для удаленной установки по SSH

Запускаем службу на компьютере на который ставим Arch Linux 

systemctl start sshd.service

Узнаем IP компьютера, на который будем ставить Arch Linux 

ip a

На компе, на который будем производить установку подключаем wi-fi командой 

wifi-menu 

и устанавливаем пароль для root командой .

passwd

Заходим на комп по ssh командой 

ssh root@000.000.0.000 

вместо нулей подставляем ip компьютера
   
##############################################

Загрузка

#Скачиваем дистрибутив с офф сайта
https://www.archlinux.org/download/

#Проверяем целостность образа
1) Открываем папку со скаченных архивом
2) Жмем, правую кнопку мышки выбираем “Открыть в терминале”
3) Вбиваем в терминале команду md5sum (+название файла)

Пример: md5sum archlinux-2019.06.01-dual.iso
Контрольная сумма 97537db63e61d20a5cb71d29145b2937 должна совпадать см. видео https://vk.cc/7S7N3o 

Актуальную контрольную сумму смотрите на оффициальном сайте https://www.archlinux.org/download/ 

Для Windows можно воспользоваться вот этой программой для проверки суммы http://hashtab.ru 

#Запишем его на флешку

sudo dd if=X of=/dev/sdY

Где X - это название ISO файла, Y - буква диска

Пример: sudo dd if=archlinux-2019.06.01-dual.iso of=/dev/sdb

В Winfows лучше записывать программой Rufus http://rufus.akeo.ie 

Чтобы избежать ошибок при разметке диска, предварительно перезапишите его нулями, например программой Disks загрузившись с USB в любом дистрибутиве Linux

#Загружаемся с флешки

ВАЖНО!
Если вы ставите с UEFI и при загрузки получаете ошибку “security Boot Fail”, то нужно зайти в BIOS  в разделе установить пароль в разделе Set Supervisor Password и в boot вкладке отключить security Boot см. https://i.imgur.com/jFLlrm0.png 

Перед установкой

Установка раскладки клавиатуры

#После загрузки настроим русский язык для удобства работы

loadkeys ru

#Изменим консольный шрифт на тот, который поддерживает кириллицу

setfont cyr-sun16

Соедиoadkeys ru
нение с Интернетом

#Подключаем проводной интернет

dhcpcd

#Или Wi-fi

wifi-menu

Синхронизация системных часов

timedatectl set-ntp true

Создание разделов

#Смотрим какие диски есть

fdisk -l

#Разбиваем диски (для ручной разметки используем fdisk, для псевдографической разбивки можно использовать команду cfdisk)

fdisk /dev/sda

Можно вызвать подсказки нажатием на клавишу “m”

#Разделяем диски (подробно в видео)
Видео, которые могут вам помочь https://vk.cc/7qwUwW  Ручная разметка дисков начинается на 5:14
Если есть желание использовать файловую систему Btrfs, то стаим вот так https://vk.com/@arch4u-ustanovka-arch-linux-na-btrfs 

Создание разделов с BIOS

# /boot 100M - выставить флаг boot командой a
# / 20G
# swap 1024M
# /home весь остаток

Создание разделов с UEFI

cfdisk /dev/sda

/dev/sda1 - 500M EFI 
/dev/sda2 - 30G root Linux File System
/dev/sda3 - Весь остаток home Linux file System

Процесс разбивки диска по шагам

См. видео https://vk.cc/7S7OMg 

#Создаем MBR таблицу

o

# Создаем новый диск

n

Жмем enter

# Выбираем primary (основной)  или extented (расширенный)
По умолчанию стоит primary (основной) поэтому просто жмем enter

# Выбор номера диска, по умолчанию подставляется следующий номер
Просто жмем enter

# Запрос на первый сектор диска
Просто жмем enter

# Запрос на последний сектор диска (Ставим + и объем памяти. Пример: +100M)
+100M

Повторяем все шаги снова для всех нужных разделов диска
Для /boot не забываем указать a и поставить 1 для установки его загрузочным 
Как все разметили не забываем все записать командой w

В итоге можете проверить, что у вас получилось командой fdisk -l
Должно получиться примерно вот так http://i.imgur.com/pgej0Nt.png 

Форматирование и монтирование разделов

Разделы с BIOS

mkfs.ext2  /dev/sda1 -L boot

mkfs.ext4  /dev/sda2 -L root

mkswap /dev/sda3 -L swap

mkfs.ext4  /dev/sda4 -L home

#Монтируем /

mount /dev/sda2 /mnt

#Создаем директорию boot и home в mnt 

mkdir /mnt/{boot,home}

#Монтируем boot

mount /dev/sda1 /mnt/boot

#Монтируем swap

swapon /dev/sda3

#Монтируем /home

mount /dev/sda4 /mnt/home

Разделы с UEFI

gdisk /dev/sda

# 8304
mkfs.ext4 /dev/sda2
mount /dev/sda2 /mnt


#ef00
mkfs.fat -F32 /dev/sda1 
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

#8302
mkfs.ext4 /dev/sda3
mkdir -p /mnt/home
mount /dev/sda3 /mnt/home


1. 
Установка

1. 
Выбор зеркал для загрузки


pacman -Sy --noconfirm --needed reflector
reflector -c "Russia" -f 20 -l 20 -p https -p http -n 20 --save /etc/pacman.d/mirrorlist --sort rate

#Для более быстрой загрузки пакетов настроим зеркала. Поставим российское зеркало Яндекса выше всех остальных

nano /etc/pacman.d/mirrorlist

#И впишем эту строку вверху, где есть Россия

Server = http://mirrors.prok.pw/archlinux/$repo/os/$arch
Server = http://mirrors.kernel.org/archlinux/$repo/os/$arch

#Сохраняем Ctr+O (Enter)
#Выходим Ctr+X
1. 
Установка основных пакетов

#Устанавливаем базовую систему + необходимые пакеты
pacstrap /mnt base base-devel
1. 
Настройка системы


Генерируем fstab, для этого используем следующую команду
genfstab -pU /mnt >> /mnt/etc/fstab

#Перейдём в установленную систему
arch-chroot /mnt

#Прописываем имя компьютера. Вместо ArchLinux впишите свое название
echo "ArchLinux" > /etc/hostname

#Настроим часы (Для Москвы)
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

#Настроим часы (Для Екатеринбурга)
ln -sf /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime


1. 
Добавляем русскую локаль системы


#Добавим русскую локаль в систему
echo -e "en_US.UTF-8 UTF-8\nru_RU.UTF-8 UTF-8" >> /etc/locale.gen

 Обновим текущую локаль системы
locale-gen

#Указываем язык системы

echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf

#Указываем keymap для console + прописываем шрифт

echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf

#Создадим загрузочный RAM диск

mkinitcpio -p linux

#Изменим пароль root

passwd

1. 
Установка загрузчика


#Обновляем базы данных пакетов:

pacman -Syy

#Устанавливаем загрузчик  (для BIOS)

pacman -S grub
grub-install /dev/sda

#Устанавливаем загрузчик  (для UEFI)

pacman -S grub efibootmgr
grub-install /dev/sda


#Если в системе будут несколько ОС, то это также ставим

pacman -S os-prober mtools fuse

#Обновляем grub.cfg

grub-mkconfig -o /boot/grub/grub.cfg

#Ставим программу для Wi-fi

pacman -S dialog wpa_supplicant


#Выходим 

exit

# Далее отмонтируем все разделы:

umount /mnt/{boot,home,}

1. 
Перезагрузка

reboot

После установки
#Логинимся
логин root
пароль тот, что установили

#Подключаем wifi
wifi-menu

#Или если у вас проводной интернет, то подключаем его
dhcpcd

1. 
Добавляем пользователя


#Добавим нового пользователя. Вместо MYUSERNAME пишем имя пользователя без спец символов, только маленькие лат. буквы

useradd -m -g users -G wheel -s /bin/bash MYUSERNAME

1. 
Устанавливаем пароль пользователя


#Установим пароль для нового пользователя. Вместо MYUSERNAME пишем имя пользователя

passwd MYUSERNAME

1. 
Устанавливаем SUDO

#Заходим в файл sudoers

nano /etc/sudoers

#В файле /etc/sudoers находим строчку # %wheel ALL=(ALL) ALL и раскомментируем ее убрав символ #

Так было: 
## Uncomment to allow members of group wheel to execute any command

#%wheel ALL=(ALL) ALL

Так должно быть:
## Uncomment to allow members of group wheel to execute any command

%wheel ALL=(ALL) ALL

#Сохраняем Ctr+O (Enter)
#Выходим Ctr+X

Теперь мы можем использовать sudo для выполнения команд администратора.

1. 
Настройка pacman

#Настроим pacman (только для x86_64):

nano /etc/pacman.conf

#Для работы 32-битных приложений в 64-битной системе необходимо раскомментировать репозиторий multilib:
 
Ставим менеджер сети

pacman -S networkmanager network-manager-applet ppp

#Подключаем автозагрузку менеджера входа и интернет (с соблюдением регистра для NetworkManager)

systemctl enable lxdm NetworkManager
1. 

SWAP FILE



Перезагрузка

#Выбираем Xfce Session или просто “Сеанс”!!!!! Это важно иначе не войдете!
1. 
Дополнительные настройки

1. 
Проприетарные драйвера для видеокарт (Условный пункт)

Если все работает нормально, то можете этот пункт пропустить.

Установим драйвер для видеокарты:

Пакеты lib32-* нужно устанавливать только на x86_64 системы.


Intel:
sudo pacman -S xf86-video-intel lib32-intel-dri

Nvidia:
sudo pacman -S nvidia  nvidia-utils  lib32-nvidia-utils

AMD:
sudo pacman -S xf86-video-ati lib32-ati-dri
Если вы устанавливаете систему на виртуальную машину:
sudo pacman -S xf86-video-vesa
1. 
Подключаем Wi-Fi

#Идем в меню - настройки - сетевые соединения. Сюда http://i.imgur.com/9fIT56r.png 
Если Wi-fi нет, то жмем сюда http://i.imgur.com/GUwknhy.png и добавляем Wi-fi
Выбираем сеть, жмем изменить, вводим пароль
1. 
Установка AUR


# yaourt и aurman более не обновляются разработчиками поэтому рекомендую к использованию именно yay. (См. таблицу https://vk.cc/88yr8q и голосование https://vk.cc/8YQdqI )

# Обновляем систему
sudo pacman -Syu

# Создаём yay_install директорию и переходим в неё
mkdir -p /tmp/yay_install
cd /tmp/yay_install

# Установка "yay" из AUR
sudo pacman -S git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -sir --needed --noconfirm --skippgpcheck
rm -rf yay_install

Если вы предпочитаете работать с графическим интерфейсом, а не с терминалом то как альтернативу yay можно использовать pamac (установщик пакетов из AUR c GUI)

# Обновляем систему
sudo pacman -Syu

# Создаём pamac-aur_install директорию и переходим в неё
mkdir -p /tmp/pamac-aur_install
cd /tmp/pamac-aur_install

# Установка "pamac-aur" из AUR
sudo pacman -S git
git clone https://aur.archlinux.org/pamac-aur.git
cd pamac-aur
makepkg -si --needed --noconfirm --skippgpcheck
rm -rf pamac-aur_install



1. 
Установка программ

#Установка пакетов, которые решают большинство проблем, с которыми вы можете столкнуться
sudo pacman -S f2fs-tools dosfstools ntfs-3g alsa-lib alsa-utils file-roller p7zip unrar gvfs aspell-ru pulseaudio 

#Установка программ
sudo pacman -S firefox doublecmd-gtk2 filezilla gimp gnome-calculator libreoffice libreoffice-fresh-ru kdenlive audacity screenfetch vlc qt4 ufw qbittorrent obs-studio veracrypt freemind

Если нужно русифицировать firefox добавляем еще и  firefox-i18n-ru 
Если русификация не вступила в силу, тогда сбросьте насройки FF https://vk.cc/9n7uLx 

#Установка AUR программ
yay -S sublime-text-dev cherrytree timeshift google-talkplugin hunspell-ru pamac-aur xflux xflux-gui-git osx-arc-shadow papirus-maia-icon-theme-git breeze-obsidian-cursor-theme xflux xflux-gui-git flameshot-git megasync-git

Рекомендуемые и используемые мной программы можете посмотреть здесь https://vk.cc/5XjUqt .
1. 
Установка тем

Темы Gtk+ для Xfce
osx-arc-shadow
yay -S vertex-themes
https://www.xfce-look.org/p/1137072/ 

Темы иконок 
papirus-maia-icon-theme-git
Faenza https://goo.gl/rE1rMi (см. видео по установке https://goo.gl/rD09sb) 
Paper Icons https://www.xfce-look.org/p/1099618/ 
Revival Icon Theme https://www.xfce-look.org/p/1099769/ 
Moka Icon Theme https://www.xfce-look.org/p/1012513/ 

Темы курсора 
sudo pcman -S capitaine-cursors
yay -S xcursor-breeze-serie-obsidian
yay -S breeze-obsidian-cursor-theme

Oxygen Neon http://vk.cc/5AcWC7 


Теперь можно менять тему для курсора в настройках. Для этого открываем «Меню» -> «Настройки» -> «Мышь и тачпад»

#Ставим тему на LXDM
yay -S lxdm-themes

#Меняем тему в настройках 
sudo nano /etc/lxdm/lxdm.conf


# Находим строку с  theme=Industrial  и заменяем на название нашей темы theme=ArchlinuxTop
ArchlinuxTop


1. 
Настройки Xfce

Смотрите видео по настройке Xfce https://vk.cc/7qwQ8L 
Настройка прозрачного терминала см. в видео https://vk.cc/9afFih Время в видео 39:36

#Настраиваем горячие клавиши на запуск терминала
#Перейдите в Settings (Настройки) > Keyboard (Клавиатура) > Application Shortcuts (Комбинации клавиш)
xfce4-terminal
Клавиши Ctrl+Alt+T

#Настраиваем горячие клавиши на скриншот
Назначьте команду 
xfce4-screenshooter -f 
на клавишу Print Screen, которая будет делать скриншоты всего экрана.

#Настраиваем горячие клавиши на системный монитор
Назначьте команду 
xfce4-taskmanager
на клавиши Ctrl+Alt+M

#Решение проблемы запуска Stеam
В горячие клавиши прописываем следующую строку:

env vbank_mode=0 STEAM_FRAME_FORCE_CLOSE=1 LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so' /usr/bin/steam %U

Ставим на клавиши Ctrl+Alt+S

#Запуск проигрывателя VLC
Ставим на клавиши Super+V
vlc

#Быстрое выключение компьютера клавишами
Ставим на клавиши Super+S
shutdown -h now

#Если нужно установить время для Екатеринбурга
timedatectl set-timezone Asia/Yekaterinburg

#Настраиваем раскладку клавиатуры
Настройки - клавиатура - раскладка выбираем Shift+Alt

#Включить звук
sudo amixer sset Master unmut

#Включить обнаружение съемных устройств
Настройки - съемные устройства и носители данных

# Настраиваем временную зону
ПКМ на времени - свойства - ставим вашу временную зону. Например Asia/Yekaterinburg
# Управление звуком на клавиатуре
https://wiki.archlinux.org/index.php/Xfce#Keyboard_volume_buttons 

#Дополнительные настройки по Xfce
https://wiki.archlinux.org/index.php/Xfce_(Русский) 

#Установка директорий по умолчанию home, music, dokuments и т.д.
Установите xdg-user-dirs,
sudo pacman -S xdg-user-dirs

а затем выполните:
$ xdg-user-dirs-update
1. 
Настройка тайлинга в Xfce

Заходим в меню - диспетчер окон - клавиатура
Находим “Разместить в левой/правой половине” и выбираете для этого действия например клавиши SUPER + Left/Rigth

1. 
Настройка сетевого экрана

Если UFW не установлен то устанавливаем его
sudo pacman -S ufw

Запускаем его:
sudo ufw enable

Добавляем в автозагрузку:
sudo systemctl enable ufw

Команда "ufw enable" включает UFW и устанавливает базовые правила. Вы можете проверить статус работы UFW следующей командой:
sudo ufw status verbose

В результате увидите подобное:

Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

Если нужно выключить, то используйте команду:
sudo ufw disable
1. 
Настройка авто входа c DМ

Если есть необходимость можно включить авто вход в систему.
sudo nano /etc/lxdm/lxdm.conf

Находим строчку #autologin= 
Раскомментируем его убрав # и после = пишем ваш логин в системе
1. 
Настройка авто входа без DМ

Ставим пакет xorg-xinit
sudo pacman -S xorg-xinit

Копируем файл .xserverrc в каталог пользователя
cp /etc/X11/xinit/xserverrc ~/.xserverrc

Создаем в домашнем каталоге файл .xinitrc с заданным текстом

Открываем
sudo nano ~/.xinitrc

Вставляем

#!/bin/sh
# Xfce передаётся по умолчанию

if [ -f $HOME/.Xresources ]; then
xrdb -merge $HOME/.Xresources
fi

#session=${1:-openbox}
session=${1:-xfce}

case $session in
awesome ) exec awesome;;
bspwm ) exec bspwm;;
catwm ) exec catwm;;
cinnamon ) exec cinnamon-session;;
dwm ) exec dwm;;
enlightenment ) exec enlightenment_start;;
ede ) exec startede;;
evilwm ) exec evilwm;;
fluxbox ) exec startfluxbox;;
gnome ) exec gnome-session;;
gnome-classic ) exec gnome-session --session=gnome-classic;;
i3 ) exec i3;;
icewm ) exec icewm-session;;
jwm ) exec jwm;;
kde ) exec startkde;;
mate ) exec mate-session;;
monster ) exec monsterwm;;
notion ) exec notion;;
openbox ) exec openbox;;
openbox ) exec openbox-session;;
lxde ) exec startlxde;;
swm ) exec swm;;
unity ) exec unity;;
xfce ) exec startxfce4;;
xmonad ) exec xmonad;;
# No known session, try to run it as command
*) exec $1;;
esac

Открываем
sudo nano ~/.bashrc

Вставляем

#
# ~/.bashrc
#

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
exec startx
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
alias tb="nc termbin.com 9999"


Вводим команду:
sudo systemctl edit getty@tty1

Вставляем текст:
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin Username --noclear %I $TERM

Вместо Username пишем свой логин

Отключаем DM (в моем примере это lxdm, у вас может быть свой DM)
sudo systemctl disable lxdm

Перезагружаемся, если все работает, то удаляем DM
sudo pacman -R lxdm

Внимание: Еcли у вас не запускается dbus (есть ошибки) то в ~/.xinitrc добавляем следующий блок перед строкой запуска окружения (например перед exec startkde):
# Dbus fix
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

Источник https://vk.cc/8g9T5s 
См. видео https://vk.cc/7qxdDf 
1. 
Делаем BackUp системы

Программа для BackUp - TimeShift (Если установка с ошибкой см. https://vk.cc/6JjPS4 )
yay -S timeshift

Видео по BackUp:
Восстановление системы Linux https://vk.cc/7qxpIq 
Как восстановить образ, когда система умерла https://vk.cc/7qxpcb
Самая частая ошибка пользователей Arch Linux https://vk.cc/7qxqmT 

Удобрый и быстрый BackUp для файловой системы BTRFS см. https://vk.cc/88ygxM 

1. 
Убираем меню граб для выбора системы

Если у вас нет второй системы, как у меня, то вы можете ускорить загрузку системы и удрать это граб меню. Делается это следующим образом.
sudo nano /etc/default/grub 

GRUB_TIMEOUT=5 меняем на GRUB_TIMEOUT=0

#Обновляем grub.cfg
sudo grub-mkconfig -o /boot/grub/grub.cfg

1. 
Обновление системы

Обновление всей системы (самого ядра, окружения рабочего стола, программ из pacman и из AUR) производится одной командой:
yay -Syu

Альтернативная команда для обновления и очистки системы
yay -Syu && sudo pacman -Scc && sudo pacman -Rsn $(pacman -Qdtq) && sudo rm -rf ~/.cache/thumbnails/*

Пояснения:
yay -Syu - обновляет ядро, программы в pacman и в aur
sudo pacman -Scc - очищает кеш пакетов, высвобождая место на диске
sudo pacman -Rsn $(pacman -Qdtq) - удаляет пакеты-сироты (которые не используются ни одной программой)
sudo rm -rf ~/.cache/thumbnails/* - удаляет миниатюры фото, которые накапливаются в системе.


1. 
Cтавим conky

sudo pacman -S conky conky-manager

Конфиг, котрый использую я  https://yadi.sk/d/MXIUinZd3WgH42 
Еще один вариант коньков от Игоря Белякова https://vk.cc/88xu0B 
1. 
Ставим курсор по умолчанию

sudo nano /usr/share/icons/default/index.theme
Меняем тему по курсора на нужную, например  Breeze Obsidian


---------------------------------------------------------------
Дополнительные видео уроки по Arch Linux 
►► https://vk.cc/7S7S7h ◄◄
---------------------------------------------------------------

##############################################
ЕСТЬ ВОПРОСЫ? 
ПОДПИШИСЬ НА РАССЫЛКИ https://vk.cc/83lAm3
ВСТУПИ В ГРУППУ https://vk.com/arch4u 
ПИШИ В НАШ LINUX CHAT
https://vk.me/join/AJQ1d87K9gAjXk7b0PeTtiJT
##############################################
Все решенные проблемы смотрите тут https://vk.cc/5RCfPo 
Вопросы, проблемы кидайте на стену группы.

Автор чек листа Бойко Алексей
https://vk.com/arch4u - Моя группа по Arch Linux
https://vk.com/linux4u - Моя группа по Linux
https://www.youtube.com/arch4u - канал на YouTube
Ответьте на небольшой опрос по Linux https://vk.cc/5YF81r 
