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

fixed_dir="$work_dir/fixedpack"
linux_dir="$work_dir/linuxpatch"

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
mkdir -p "$fixed_dir"
mkdir -p "$linux_dir"

cd "$work_dir" || exit 1

# Descargando archivos
echo -e "\n\n${greenColour}[+] Download Tactical Ops Fixed Pack v469e...${endColour}\n"
wget -c --no-check-certificate "$url_tov469" -O "$work_dir/$tov469_zip"

echo -e "\n\n${greenColour}[+] Download LinuxFiles...${endColour}\n"
wget -c --no-check-certificate "$url_to_linux" -O "$work_dir/$to_linux_zip"

# extraer carpetas
echo -e "\n\n${greenColour}[+] Descomprimiendo Fixed Pack...${endColour}\n"
unzip -o "$work_dir/$tov469_zip" -d "$fixed_dir"

echo -e "\n\n${greenColour}[+] Descomprimiendo LinuxFiles Patch...${endColour}\n"
unzip -o "$work_dir/$to_linux_zip" -d "$linux_dir"

# Validar extracción
if [ ! -d "$fixed_dir/TacticalOps" ]; then
    echo -e "\n\n${redColour}[!] ERROR: No se encontró TacticalOps dentro del Fixed Pack.${endColour}\n"
    exit 1
fi

if [ ! -d "$linux_dir/TacticalOps" ]; then
    echo -e "\n\n${redColour}[!] ERROR: No se encontró TacticalOps dentro del parche LinuxFiles.${endColour}\n"
    exit 1
fi

# Instalar el juego completo (Fixed Pack)
echo -e "\n\n${blueColour}[!] Instalando Tactical Ops Fixed Pack en $game_dir/TacticalOps ...${endColour}\n"
mkdir -p "$game_dir/TacticalOps"
cp -r "$fixed_dir/TacticalOps/"* "$game_dir/TacticalOps/"

# Aplicar parche Linux SOLO a System
echo -e "\n\n${blueColour}[!] Aplicando parche LinuxFiles (solo System)...${endColour}\n"

# TO340
if [ -d "$linux_dir/TacticalOps/TO340/System" ]; then
    mkdir -p "$game_dir/TacticalOps/TO340/System"
    cp -r "$linux_dir/TacticalOps/TO340/System/"* "$game_dir/TacticalOps/TO340/System/"
    echo -e "\n${greenColour}[+] Parche aplicado TO340${endColour}"
else
    echo -e "\n${yellowColour}[!] No se encontró parche TO340/System (se omite)${endColour}"
fi

# TO350
if [ -d "$linux_dir/TacticalOps/TO350/System" ]; then
    mkdir -p "$game_dir/TacticalOps/TO350/System"
    cp -r "$linux_dir/TacticalOps/TO350/System/"* "$game_dir/TacticalOps/TO350/System/"
    echo -e "\n${greenColour}[+] Parche aplicado TO350${endColour}"
else
    echo -e "\n${yellowColour}[!] No se encontró parche TO350/System (se omite)${endColour}"
fi

rm -rf "$work_dir"

echo -e "\n\n${greenColour}[+] Instalación finalizada.${endColour}\n"