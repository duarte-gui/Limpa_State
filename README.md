# Limpa_State

Este script tem como finalidade resolver alguns problemas de conexões antigas já inválidas pra quem usa Failover ou LoadBalance 
em terminais VoIP!

Meu cenário é:
           
                                   
Asterisk ---pfsense(failover/loadbalance)===< VPN >====(failove/loadbalance)Mikrotik/pfSense------ Interfone IP e ATA
                                                     
                           

Meu problema era:

Quando qualquer WAN caia, tanto do lado do servidor asterisk quanto do lado dos terminais, os states dos 
equipamentos VoIP ficavam "presos" no link anterior, resultando em problemas de falta de áudio ou até mesmo 
falhas de autenticação.

Solução temporária:

Executar o limpaState.sh no servidor asterisk a cada 2 minutos via cron.
Esse script faz uma verificação dos peers com status UREACHABLE e quando encontra, conecta via ssh no router/firewall
e limpa todos os states referentes ao peer UNREACHABLE.
No script eu também precisei cobrir uma filial que conecta equipamentos VoIP no servidor asterisk da matriz.

=============================Requisitos========================
sshpass 
awk

