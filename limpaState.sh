#!/bin/bash


asterisk -x "sip show peers" |grep UNREACHABLE |egrep '[0-9\.]{6,}' | awk '{print $2}' > unreachable.txt

ip_do_pfsense=$(for s in $(cat unreachable.txt | cut -d. -f1-3); do echo "$s.1"; done)
ip_comeco_PR=$(for k in $(cat unreachable.txt | cut -d. -f1); do echo "$k"; done)
ip_comeco_SP=$(for l in $(cat unreachable.txt | cut -d. -f1); do echo "$l"; done)
ip_do_VoIP=
senha_PR=
senha_SP=


if [ $ip_comeco_PR -eq 11 ];
    then
        eval  j=$senha_PR


        for i in $(cat unreachable.txt); do
                sshpass -p  $j ssh -p 22 root@$ip_do_pfsense pfctl -k $i -k $ip_do_VoIP
                sshpass -p  $j ssh -p 22 root@$ip_do_pfsense pfctl -k $ip_do_VoIP -k $i
                echo "O ip do pfSense onde o equipamento SIP está offline é: $ip_do_pfsense"
                echo "O ip do equipamento SIP off-line é: $i"
                echo -n  > unreachable.txt
                echo "A senha usada foi $j"
        done
fi

if [ $ip_comeco_SP -eq 10 ];
    then        
        eval  j=$senha_SP

        for i in $(cat unreachable.txt); do
                sshpass -p  $j ssh -p 22 root@$ip_do_pfsense pfctl -k $i -k $ip_do_VoIP
                sshpass -p  $j ssh -p 22 root@$ip_do_pfsense pfctl -k $ip_do_VoIP -k $i
                echo "O ip do pfSense onde o equipamento SIP está offline é: $ip_do_pfsense"
                echo "O ip do equipamento SIP off-line é: $i"
                echo -n  > unreachable.txt
                echo "A senha usada foi $j"
        done
fi

