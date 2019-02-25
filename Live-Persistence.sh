#!bin/bash
#Title........: Live-Persistence.sh
#Description..: This is a bash script for making a persistent USB.
#Author.......: KChitnis
#Date.........: 20190225
#Version......: v0.1-alpha
#Usage........: bash Live-Persistence.sh
#Bash Version.: 4.2 or later
lsblk
echo "Type the persistence partition name [eg.sdxx]:"
read p
while true; do
    read -p "Do you wish to format /dev/$p?" yn
    case $yn in
        [Yy]* ) mkfs.ext3 -L persistence /dev/$p
                e2label /dev/$p persistence; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo "Enter the name of the directory you want:"
read d
mkdir -p /mnt/$d
/dev/$p /mnt/$d
echo "/ union" > /mnt/$d/persistence.conf
umount /dev/$p           
