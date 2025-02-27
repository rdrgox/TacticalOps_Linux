#!/bin/bash
# created by Rodrigo (BlackLung)

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

game_dir="$HOME"
patch_to="$HOME/TO_Linux"

tov469_7z="TO-Fixed-Pack-v469d.7z"
to_linux_zip="TOFP469d-LinuxFiles.zip"

url_tov469="https://mirror.tactical-ops.eu/client-patches/custom-clients/TO-Fixed-Pack-v469d.7z"
url_to_linux="https://mirror.tactical-ops.eu/client-patches/custom-clients/fixed-pack-addons/TOFP469d-LinuxFiles.zip"

function ctrl_c(){
    echo -e "\n\n${redColour}[!] Saliendo...${endColour}\n"
    exit 1
}

# ctrl+c
trap ctrl_c SIGINT

echo -e "\n\n${blueColour}[!] Verificando dependencias...${endColour}\n"

if ! which wget >/dev/null; then
  echo -e "\n\n${greenColour}[+] Instalando wget...${endColour}\n"
    sudo apt-get update
    sudo apt-get install wget -y
fi

if ! which unzip >/dev/null; then
  echo -e  "\n\n${greenColour}[+] Instalando unzip...${endColour}\n"
    sudo apt-get update
    sudo apt-get install unzip -y
fi

if ! which 7z >/dev/null; then
  echo -e  "\n\n${greenColour}[+] Instalando 7z...${endColour}\n"
    sudo apt-get update
    sudo apt-get install p7zip-full -y
fi

echo -e "\n\n${greenColour}[+] Dependencias instaladas...${endColour}\n"

if [ ! -d "$HOME/Downloads/" ]; then
    mkdir "$HOME/Downloads/"
fi

# Descargando archivos
echo -e "\n\n${greenColour}[+] Descargando Tactical Ops Fixed Pack v469d...${endColour}\n"
wget -c --no-check-certificate "$url_tov469" -O "$HOME/Downloads//$tov469_7z"

echo -e "\n\n${greenColour}[+] Descargando LinuxFiles...${endColour}\n"
wget -c --no-check-certificate "$url_to_linux" -O "$HOME/Downloads//$to_linux_zip"

if [ ! -d "$game_dir" ]; then
    mkdir "$game_dir"
fi

# Mueve el archivo TO-Fixed-Pack-v469d.7z a ~/TacticalOps
if [ -f "$HOME/Downloads//$tov469_7z" ]; then
    cd "$game_dir"
    mv "$HOME/Downloads//$tov469_7z" .
else
    echo -e "\n\n${redColour}[!] El archivo $tov469_7z no existe en la carpeta de descargas${endColour}\n"
    exit 1
fi

if [ -f "$tov469_7z" ]; then
    7z x "$tov469_7z"
    rm -r "$tov469_7z"
else
    echo -e "\n\n${redColour}[!] El archivo $tov469_7z no existe${endColour}\n"
    exit 1
fi

if [ ! -d "$patch_to" ]; then
    mkdir "$patch_to"
fi

# Mueve el archivo TOFP469d-LinuxFiles.zip a ~/TO_Linux
if [ -f "$HOME/Downloads//$to_linux_zip" ]; then
    cd "$patch_to"
    mv "$HOME/Downloads//$to_linux_zip" .
else
    echo -e "\n\n${redColour}[!] El archivo $to_linux_zip no existe en la carpeta de descargas${endColour}\n"
    exit 1
fi

if [ -f "$to_linux_zip" ]; then
    unzip "$to_linux_zip"   
    rm -r "$to_linux_zip"
else
    echo -e "\n\n${redColour}[!] El archivo $to_linux_zip no existe${endColour}\n"
    exit 1
fi

function copying_files() {
    echo -e "\n\n${blueColour}[!] Copiando archivos v340 Linux${endColour}\n"
    cd "$patch_to"/TacticalOps/TO340
    if cp -r System/* "$game_dir"/TacticalOps/TO340/System/; then
        echo -e "\n\n${greenColour}[+] Archivos copiados exitosamente${endColour}\n"
    else
        echo -e "\n\n${redColour}[!] Error al copiar archivos${endColour}\n"
    fi

    echo -e "\n\n${blueColour}[!] Copiando archivos v350 Linux${endColour}\n"
    cd "$patch_to"/TacticalOps/TO350
    if cp -r System/* "$game_dir"/TacticalOps/TO350/System/; then
        echo -e "\n\n${greenColour}[+] Archivos copiados exitosamente${endColour}\n"
    else
        echo -e "\n\n${redColour}[!] Error al copiar archivos${endColour}\n"    
    fi
}

copying_files
rm -r "$patch_to"
chmod +x "$game_dir"/TacticalOps/TO340/System/TacticalOps.sh
chmod +x "$game_dir"/TacticalOps/TO350/System/TacticalOps.sh
