#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
timedatectl set-ntp true
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist_copy
echo "Server = https://mirror.osbeck.com/archlinux/$repo/os/$arch" >> /etc/pacman.d/mirrorlist
pacman -Syy
pacman -Sy os-prober git bluez bluez-utils brightnessctl snapper grub-btrfs linux-headers ineutils pulseaudio pulseaudio-bluetooth efibootmgr base-devel xorg netctl dialog dhcpcd wpa_supplicant ifplugd nano vim tlp dmenu ntfs-3g xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils terminator tlp amd-ucode
pacman -S --noconfirm xf86-video-amdgpu
passwd
useradd -G wheel,audio,video -m jatin
passwd jatin
echo "jatin ALL=(ALL) ALL" >> /etc/sudoers.d/jatin
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

