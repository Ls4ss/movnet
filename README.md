# Man-in-the-middle
O ataque MITM trabalha encima da captura de dados descriptografados e URL's que trafegam em toda
rede ou em alvos especificos.
Esse pequeno script de rápida execução facilitará esse tipo de ataque apenas com a obtenção de 
pequenas informações sequenciais, como IP do roteador, IP do alvo e interface de rede utilizada.

#Instalação
Após o download do arquivo, navegue pelo terminal do seu sistema até onde se encontra o script "mitm.sh",
em seguida de as permissões de execução com "chmod +x mitm.sh".
Feito isso e estando no mesmo diretório que o script se encontra, é só executa-lo "./mitm.sh"

(as aspas em nenhum dos casos são necessárias)

Caso o script não reconheça suas interfaces de rede você mesmo poderá realizar essa mudança diretamente
no código fonte, trocando as interfaces padrão "eth0" e "wlan0" pelas suas interfaces utilizadas.


Fique avontade para contribuir e aperfeiçoar essa ferramenta. :)

By: Lucas Silva | Twitter: @SrSniffer
