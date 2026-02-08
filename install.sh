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
work_dir="$HOME/TO_Installer_Temp"

tov469_zip="TO-Fixed-Pack-v469e.zip"
to_linux_zip="TOFP469d-LinuxFiles.zip"

url_tov469="https://mirror.tactical-ops.eu/client-patches/custom-clients/TO-Fixed-Pack-v469e.zip"
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

echo -e "\n\n${greenColour}[+] Dependencias instaladas...${endColour}\n"


# Crear carpeta de trabajo
rm -rf "$work_dir"
mkdir -p "$work_dir"

cd "$work_dir" || exit 1

# Descargando archivos
echo -e "\n\n${greenColour}[+] Download Tactical Ops Fixed Pack v469e...${endColour}\n"
wget -c --no-check-certificate "$url_tov469" -O "$tov469_zip"

echo -e "\n\n${greenColour}[+] Download LinuxFiles...${endColour}\n"
wget -c --no-check-certificate "$url_to_linux" -O "$to_linux_zip"

echo -e "\n\n${greenColour}[+] Descomprimiendo $tov469_zip...${endColour}\n"
unzip -o "$tov469_zip"

echo -e "\n\n${greenColour}[+] Descomprimiendo $to_linux_zip...${endColour}\n"
unzip -o "$to_linux_zip"

# Validar extracción
if [ ! -d "$work_dir/TacticalOps" ]; then
    echo -e "\n\n${redColour}[!] ERROR: No se encontró la carpeta TacticalOps luego de extraer.${endColour}\n"
    echo -e "${yellowColour}[!] Puede que el ZIP extraiga con otra estructura de carpetas.${endColour}\n"
    exit 1
fi

function copying_files() {

    mkdir -p "$game_dir/TacticalOps/TO340/System"
    mkdir -p "$game_dir/TacticalOps/TO350/System"

    echo -e "\n\n${blueColour}[!] Copiando archivos v340 Linux${endColour}\n"

   if [ -d "$work_dir/TacticalOps/TO340/System" ]; then
        cp -r "$work_dir/TacticalOps/TO340/System/"* "$game_dir/TacticalOps/TO340/System/" && \
        echo -e "\n\n${greenColour}[+] Archivos copiados exitosamente (TO340)${endColour}\n" || \
        echo -e "\n\n${redColour}[!] Error al copiar archivos (TO340)${endColour}\n"
    else
        echo -e "\n\n${redColour}[!] No existe la carpeta fuente: $patch_to/TacticalOps/TO340/System${endColour}\n"
    fi

    echo -e "\n\n${blueColour}[!] Copiando archivos v350 Linux${endColour}\n"

    if [ -d "$work_dir/TacticalOps/TO350/System" ]; then
        cp -r "$work_dir/TacticalOps/TO350/System/"* "$game_dir/TacticalOps/TO350/System/" && \
        echo -e "\n\n${greenColour}[+] Archivos copiados exitosamente (TO350)${endColour}\n" || \
        echo -e "\n\n${redColour}[!] Error al copiar archivos (TO350)${endColour}\n"
    else
        echo -e "\n\n${redColour}[!] No existe la carpeta fuente: $patch_to/TacticalOps/TO350/System${endColour}\n"
    fi
}

copying_files
rm -rf "$work_dir"

echo -e "\n\n${greenColour}[+] Instalación finalizada.${endColour}\n"