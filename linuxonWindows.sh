#!/bin/bash
# My first script

HOME_DIR="/home/$SUDO_USER"

set -e

if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

./poky-glibc-x86_64-rpizerowifi-sdk-arm1176jzfshf-vfp-raspberrypi0-wifi-toolchain* -y
sudo apt-get install make -y
sudo apt-get update -y
sudo apt-get install gcc -y
sudo apt-get install g++ -y
sudo apt-get install gcc-arm-linux-gnueabi -y
rm -R -f $HOME_DIR/sources/
rm -R -f $HOME_DIR/bin.tar*
rm -R -f $HOME_DIR/bin
mkdir -p $HOME_DIR/sources
sudo cp rpi-* $HOME_DIR/sources/
sudo cp bin.tar* $HOME_DIR/
cd $HOME_DIR/sources/
tar -xf rpi-* --checkpoint=.100
cd $HOME_DIR/
sudo tar -xvf bin.tar*
sudo echo 'export PATH=~/bin:$PATH' >> .bashrc
sudo echo 'source ~/bin/addarmcompiler' >> .bashrc
sudo apt-get install bison flex -y
sudo apt install libssl-dev -y
cd $HOME_DIR/sources/rpi-*/
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- rpizw_defconfig
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- modules_prepare
sudo apt-get install libc6-dev-i386 -y
sudo apt-get install libz-dev -y
sudo apt-get install gcc-arm-linux-gnueabi -y
sudo apt-get install g++-arm-linux-gnueabi -y
cd /usr/include/openssl/
sudo ln -s -f /usr/include/gnutls/openssl.h .
sudo ln -s -f ../x86_64-linux-gnu/openssl/opensslconf.h .
. $HOME_DIR/.bashrc


