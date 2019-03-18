# ArchLinux Fast Install
This script install ArchLinux XFCE + AUR + XFCE config. Also you can add own /home directory as well as XFCE config.

# Описание
Этот скрипт для персональной установки ArchLinux XFCE + AUR + XFCE config.

Cкрипт основан на моем чек листе ручной установке ArchLinux https://vk.cc/7JTg6U
Разметка MBR c BIOS. C UEFI пока установки нет. В планах.
Cостоит из 3 частей. 
Видео с демонстацией работы скрипта https://www.youtube.com/watch?v=nvVF_qKDUeM

# Установка 
1) Скачать и записать на флешку ISO образ Arch Linux https://www.archlinux.org/download/
2) Запустить терминал и вбить команду:

   ```bash 
   wget git.io/arch1.sh && sh arch1.sh
   ```
   Запустится установка минимально системы с DE XFCE.
   2-я часть ставится автоматически и это базаовая установка ArchLinux без программ. 
3) 3-я часть не обязательная.
   3-я версия устанавливает программы,AUR, мои конфиги XFCE.
   Предварительно нужно установить wget:
   ```bash 
   sudo pacman -S wget
   ```
   Устанавливается из терминала командой:
   
   ```bash 
   wget git.io/arch3.sh && sh arch3.sh
   ```

Далее, вы можете загрузить скрипт на свой хостинг или github аккаунт и производить быстрое разворачивание вашей системы.
По завершению работы скрипта вы получаете вашу готовую и настроенную систему со всеми конфигами. Вам ее нужно лишь немного привести в порядок и все.

# ВНИМАНИЕ!
Автор не несет ответственности за любое нанесение вреда при использовании скрипта. Используйте его на свой страх и риск или изменяйте под свои личные нужды.

Если вам не подходит автоматическая разметка дисков, тогда вам, предварительно вам нужно сделать разметку дисков и настроить скрипт под свои нужды (программы, XFCE config и т.д.)
Смотрите пометки в самом скрипте.

# Контакты
Наша группа по Arch Linux https://vk.com/arch4u

Linux Chat https://t.me/linux4u

# История изменений
18.03.2019 
- Теперь можно вводить собственное имя хоста и юзера
- Исправлен 3-й файл с установкой темой
- aurman заменен на yay
