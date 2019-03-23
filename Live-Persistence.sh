#!bin/bash
#Title........: Live-Persistence.sh
#Description..: This is a bash script for making a persistent USB.
#Author.......: KChitnis
#Date.........: 20190225
#Version......: v0.1-alpha
#Usage........: bash Live-Persistence.sh
#Bash Version.: 4.2 or later
lsblk
tput setaf 2; echo "Type the persistence partition name [eg.sdxx]:"
read p
tput setaf 2; umount /dev/$p
while true; do
   tput setaf 1; read -p "Do you wish to format /dev/$p?" yn
    case $yn in
        [Yy]* ) mkfs.ext3 -L persistence /dev/$p
                e2label /dev/$p persistence; break;;
        [Nn]* ) exit;;
        * ) tput setaf 1; echo "Please answer yes or no.";;
    esac
done
tput setaf 2; echo "Enter the name of the directory you want:"
read d
mkdir -p /mnt/$d
mount /dev/$p /mnt/$d
echo "/ union" > /mnt/$d/persistence.conf
umount /dev/$p           
