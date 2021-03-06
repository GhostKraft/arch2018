#!/bin/bash
read -p "Введите имя компьютера: " hostname
read -p "Введите имя пользователя: " username

echo 'Прописываем имя компьютера'
echo $hostname > /etc/hostname

echo 'Выбираем часовой пояс'
ln -svf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

echo '3.4 Добавляем русскую локаль системы'
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf
echo "KEYMAP=ru" >> /etc/vconsole.conf
echo "FONT=cyr-sun16" >> /etc/vconsole.conf


echo 'Создадим загрузочный RAM диск'
mkinitcpio -p linux

echo '3.5 Устанавливаем загрузчик'
pacman -Syy
pacman -S grub --noconfirm 
grub-install /dev/sda

echo 'Обновляем grub.cfg'
grub-mkconfig -o /boot/grub/grub.cfg

echo 'Добавляем пользователя'
useradd -m -g users -G wheel -s /bin/bash $username

echo 'Создаем root пароль'
passwd

echo 'Устанавливаем пароль пользователя'
passwd $username

echo 'Устанавливаем SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

echo 'Раскомментируем репозиторий multilib Для работы 32-битных приложений в 64-битной системе.'
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
pacman -Syy

echo 'Ставим иксы и драйвера'
pacman -S xorg xorg-server xorg-apps xorg-xinit --noconfirm

echo 'Ставим драйвера видеокарты intel'
sudo pacman -S xf86-video-intel vdpauinfo libva-utils libva-intel-driver libva lib32-libva-intel-driver libvdpau libvdpau-va-gl lib32-libvdpau --noconfirm

echo 'Устанавливаем экранный менеджер'
pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm

echo "ВЫБИРАЕМ окнонный менеджер или окружение WM/DE"
read -p "1 - BSPWM, 2 - I3-GAPS, 3 - Openbox, 4 - XFCE, 5 - JWM: " vm_setting
if [[ $vm_setting == 1 ]]; then
  pacman -S bspwm sxhkd slop rxvt-unicode --noconfirm 
mkdir -p /home/$username/.config/{bspwm,sxhkd}
cp /usr/share/doc/bspwm/examples/bspwmrc /home/$username/.config/bspwm/
cp /usr/share/doc/bspwm/examples/sxhkdrc /home/$username/.config/sxhkd/
chmod +x /home/$username/.config/bspwm/bspwmrc    
chown -R $username:users /home/$username/.config/
echo 'BSPWM успешно установлено'
elif [[ $vm_setting == 2 ]]; then
  pacman -S i3-gaps i3blocks --noconfirm
echo 'I3-gaps успешно установлено'
elif [[ $vm_setting == 3 ]]; then  
  pacman -S openbox tint2 lxappearance lxappearance-obconf python-xdg --noconfirm
echo 'OPENBOX успешно установлено'
elif [[ $vm_setting == 4 ]]; then  
  pacman -S xfce4 --noconfirm
echo 'XFCE успешно установлено'
elif [[ $vm_setting == 5 ]]; then  
  pacman -S jwm --noconfirm
echo 'JWM успешно установлено'
fi

echo 'Ставим базовый софт'
pacman -S termite pcmanfm rofi lxappearance nitrogen polkit-gnome lxtask gparted hardinfo dunst viewnior flameshot geany ntfs-3g mtools bash-completion qt5-styleplugins qt5ct xorg-xsetroot firefox firefox-i18n-ru gsimplecal unrar tar file-roller --noconfirm

echo 'Ставим шрифты'
pacman -S ttf-liberation ttf-dejavu ttf-droid ttf-hack --noconfirm 

echo 'Ставим NetworkManager'
pacman -S networkmanager nm-connection-editor ppp --noconfirm 

echo 'Подключаем автозагрузку менеджера входа и интернет'
systemctl enable lightdm.service NetworkManager

echo 'Установка завершена! Перезагрузите систему reboot.'
exit
