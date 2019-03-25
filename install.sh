#!/bin/bash
[ $(id -u) -ne 0 ] && { echo -e "root?"; sudo ./install.sh ; exit ;} || echo -e "*Iniciando Instalação"
sleep 1
echo "*atribuindo permissões"
chmod +x movnet.sh
chmod +x target.sh
chmod +x tools.sh
./movnet.sh