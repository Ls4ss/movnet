#!/bin/bash
[ $(id -u) -ne 0 ] && { echo -e "root?"; sudo ./install.sh ; exit ;} || echo -e "*Iniciando Instalação"
sleep 1
echo "*atribuindo permissões"
chmod +x mitm.sh
chmod +x alvo.sh
sleep 1
echo "*Copiando arquivos"
sleep 1
cp mitm.sh /bin
cp alvo.sh /bin
echo "*Instalação Concluida"
echo "*Deseja iniciar o script s/n?"
read val
if [[ "$val" = s ]]; then
mitm.sh
else
	exit
fi