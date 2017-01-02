 #
 # Copyright � 2017,  Sultan Qasim Khan <sultanqasim@gmail.com> 	
 # Copyright � 2017,  Zeeshan Hussain <zeeshanhussain12@gmail.com> 	      
 # Copyright � 2017,  Varun Chitre  <varun.chitre15@gmail.com>	
 # Copyright � 2017,  Carlos Arriaga  <CarlosArriagaCM@gmail.com>	
 #
 # Custom build script
 #
 # This software is licensed under the terms of the GNU General Public
 # License version 2, as published by the Free Software Foundation, and
 # may be copied, distributed, and modified under those terms.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 # Please maintain this if you use this script or any part of it
 #

usage (){
        clear
        echo "||";
        echo "||     Use: $0 DEVICE";
        echo "||";
        echo "||     Example: $0 wt88047";
        echo "||";
        echo "|| [Device] = Device codename: wt88047";
        echo "||";
        echo "|| $1"
        exit 1;
}

shift $((OPTIND-1))

if [ "$#" -ne 1 ]; then
        usage "No Found Device"
fi

DEVICE="$1"

#Variable
VERSION="R03"
USUARIO="ortizpablo199"
DIRECTORIO="/home/$USUARIO/android_kernel_wingtech_msm8916"
KERNELT="/home/$USUARIO/android_kernel_wingtech_msm8916/arch/arm/boot/zImage"
ZIP="/home/$USUARIO/android_kernel_wingtech_msm8916/zip"

#!/bin/bash
BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'

#Borrando Basura
echo -e "Clean Shit"
make clean && make mrproper

#Configurando kernel
export KBUILD_BUILD_USER="CarlosArriaga"
export KBUILD_BUILD_HOST="xda-developers"
echo -e "$yellow**********************************************"
echo "       Building Explosion Kernel For "$DEVICE"    "
echo -e "**********************************************$nocol"
echo -e "Initial defconfig"
make ARCH=arm "$DEVICE"_defconfig
echo -e "Building kernel"
make -j8 ARCH=arm CROSS_COMPILE=~/arm-eabi-4.9/bin/arm-eabi-

echo -e "$red Compress zip"
rm -rvf $ZIP/zImage
mv $KERNELT $ZIP
rm -f $ZIP/*.zip

cd $ZIP
zip -r Explosion-$VERSION-$DEVICE *
cd
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$yellow Construcción completada en $(($DIFF / 60)) minuto(s) y $(($DIFF % 60)) segundos.$nocol"
