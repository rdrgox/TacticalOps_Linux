#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

game_dir="$HOME/TacticalOps"
tov469_7z="TO-Fixed-Pack-v469c.7z"
to_linux_zip="TOFP-LinuxFiles-x64-v6.zip"

function ctrl_c(){
    echo -e "\n\n${redColour}[!] Saliendo...${endColour}\n"
    exit 1
}

# ctrl+c
trap ctrl_c SIGINT


function install_dependencies() {
    echo -e "\n\n${greenColour}[!] Instalando dependencias...${endColour}\n"
    sudo apt-get update
    sudo apt-get install wget zip p7zip-full -y
}

function download_to() {
    # Descargando archivos
    echo -e "\n\n${blueColour}[!] Descargando Tactical Ops Fixed Pack v469c...${endColour}\n"
    wget -c --no-check-certificate "https://drive.google.com/uc?export=download&id=1i4ErENP0Iab14cnLbafabIHZzfQQwYYc&confirm=t" -O ~/Download/TO-Fixed-Pack-v469c.7z

    echo -e "\n\n${blueColour}[!] Descargando LinuxFiles-x64-v6...${endColour}\n"
    wget -c --no-check-certificate "https://drive.google.com/uc?export=download&id=1k52Jw1dNRL2pg8biktuBFzWTeZOyJBI2&confirm=t" -O ~/Download/TOFP-LinuxFiles-x64-v6.zip
}

function create_dir() {
    mkdir -p "$game_dir"
    cd "$game_dir"
}

# Mueve el archivo TO-Fixed-Pack-v469c.7z a ~/TacticalOps
if [ -f $HOME/Download/"$tov469_7z" ]; then
    mv $HOME/Download/"$tov469_7z" .
else
    echo -e "\n\n${redColour}[!] El archivo "$tov469_7z" no existe en la carpeta Download${endColour}\n"
    exit 1
fi

# Mueve el archivoTOFP-LinuxFiles-x64-v6.zip a ~/TacticalOps
if [ -f ~/Download/"$to_linux_zip" ]; then
    mv ~/Download/"$to_linux_zip" .
else
    echo -e "\n\n${redColour}[!] El archivo "$to_linux_zip" no existe en la carpeta Download${endColour}\n"
    exit 1
fi

function unzip() {
    if [ -f "$tov469_7z" ]; then
        7z e "$tov469_7z"
        rm -r "$tov469_7z"
    else
        echo "\n\n${redColour}[!] el archivo"$tov469_7z" no existe${endColour}\n"
    fi

    if [ -f"$to_linux_zip"    ]; then
        unzip "$to_linux_zip"   
        rm -r "$to_linux_zip"   
    else
        echo "\n\n${redColour}[!] el archivo"$to_linux_zip" no existe${endColour}\n"
    fi
}


install_dependencies
download_to
create_dir
unzip
