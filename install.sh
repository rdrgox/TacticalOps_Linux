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

tov469_7z="TO-Fixed-Pack-v469e.7z"
to_linux_zip="TOFP469d-LinuxFiles.zip"

url_tov469="https://mirror.tactical-ops.eu/client-patches/custom-clients/TO-Fixed-Pack-v469e.7z"
url_to_linux="https://mirror.tactical-ops.eu/client-patches/custom-clients/fixed-pack-addons/TOFP469d-LinuxFiles.zip"

function ctrl_c(){
    echo -e "\n\n${redColour}[!] Saliendo...${endColour}\n"
    exit 1
}

# ctrl+c
trap ctrl_c SIGINT

install_pkg() {
    pkg="$1"

    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install -y "$pkg"

    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -Sy --noconfirm "$pkg"

    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y "$pkg"

    elif command -v zypper >/dev/null 2>&1; then
        sudo zypper install -y "$pkg"

    else
        echo -e "${redColour}[!] No se pudo detectar un gestor de paquetes compatible${endColour}"
        exit 1
    fi
}

echo -e "\n\n${blueColour}[!] Verificando dependencias...${endColour}\n"

# wget
if ! command -v wget >/dev/null; then
    echo -e "\n\n${greenColour}[+] Instalando wget...${endColour}\n"
    install_pkg wget
fi

# unzip
if ! which unzip >/dev/null; then
    echo -e  "\n\n${greenColour}[+] Instalando unzip...${endColour}\n"
   install_pkg unzip
fi

# 7z
if ! command -v 7z >/dev/null; then
    echo -e "\n\n${greenColour}[+] Instalando 7z...${endColour}\n"

    if command -v apt-get >/dev/null; then
        install_pkg p7zip-full
    else
        install_pkg p7zip
    fi
fi

echo -e "\n\n${greenColour}[+] Dependencias instaladas...${endColour}\n"


# Crear carpeta Downloads si no existe
if [ ! -d "$HOME/Downloads/" ]; then
    mkdir "$HOME/Downloads/"
fi

# Descargando archivos
echo -e "\n\n${greenColour}[+] Download Tactical Ops Fixed Pack v469e...${endColour}\n"
wget -c --no-check-certificate "$url_tov469" -O "$HOME/Downloads//$tov469_7z"

echo -e "\n\n${greenColour}[+] Download LinuxFiles...${endColour}\n"
wget -c --no-check-certificate "$url_to_linux" -O "$HOME/Downloads//$to_linux_zip"

if [ ! -d "$game_dir" ]; then
    mkdir "$game_dir"
fi

# Mueve el archivo TO-Fixed-Pack-v469e.7z a ~/TacticalOps
if [ -f "$HOME/Downloads//$tov469_7z" ]; then
    cd "$game_dir"
    mv "$HOME/Downloads//$tov469_7z" .
else
    echo -e "\n\n${redColour}[!] El archivo $tov469_7z no existe en la carpeta de descargas${endColour}\n"
    exit 1
fi

# Extrae TO-Fixed-Pack-v469e.7z
if [ -f "$tov469_7z" ]; then
    7z x "$tov469_7z"
    rm -r "$tov469_7z"
else
    echo -e "\n\n${redColour}[!] El archivo $tov469_7z no existe${endColour}\n"
    exit 1
fi

# Validar extracción
if [ ! -d "$game_dir/TacticalOps" ]; then
    echo -e "\n\n${redColour}[!] ERROR: No se encontró la carpeta TacticalOps después de extraer el .7z${endColour}\n"
    echo -e "${yellowColour}[!] Posible causa: el .7z se extrae con otra estructura de carpetas.${endColour}\n"
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

# Extraer zip LinuxFiles
if [ -f "$to_linux_zip" ]; then
    unzip "$to_linux_zip"   
    rm -r "$to_linux_zip"
else
    echo -e "\n\n${redColour}[!] El archivo $to_linux_zip no existe${endColour}\n"
    exit 1
fi

function copying_files() {

    mkdir -p "$game_dir/TacticalOps/TO340/System"
    mkdir -p "$game_dir/TacticalOps/TO350/System"

    echo -e "\n\n${blueColour}[!] Copiando archivos v340 Linux${endColour}\n"

   if [ -d "$patch_to/TacticalOps/TO340/System" ]; then
        cp -r "$patch_to/TacticalOps/TO340/System/"* "$game_dir/TacticalOps/TO340/System/" && \
        echo -e "\n\n${greenColour}[+] Archivos copiados exitosamente (TO340)${endColour}\n" || \
        echo -e "\n\n${redColour}[!] Error al copiar archivos (TO340)${endColour}\n"
    else
        echo -e "\n\n${redColour}[!] No existe la carpeta fuente: $patch_to/TacticalOps/TO340/System${endColour}\n"
    fi

    echo -e "\n\n${blueColour}[!] Copiando archivos v350 Linux${endColour}\n"

    if [ -d "$patch_to/TacticalOps/TO350/System" ]; then
        cp -r "$patch_to/TacticalOps/TO350/System/"* "$game_dir/TacticalOps/TO350/System/" && \
        echo -e "\n\n${greenColour}[+] Archivos copiados exitosamente (TO350)${endColour}\n" || \
        echo -e "\n\n${redColour}[!] Error al copiar archivos (TO350)${endColour}\n"
    else
        echo -e "\n\n${redColour}[!] No existe la carpeta fuente: $patch_to/TacticalOps/TO350/System${endColour}\n"
    fi
}

copying_files
rm -r "$patch_to"

echo -e "\n\n${greenColour}[+] Instalación finalizada.${endColour}\n"