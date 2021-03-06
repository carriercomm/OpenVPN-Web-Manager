#!/bin/bash

# $1 = Nom de compte
# $2 = Email du compte sur site

#Definition des variables
IP=5.196.9.112
PO=1193
CN=$1
EMAIL=$2
LIENSCRIPTFOLDER=$(pwd)

#Creation des certificats
cd /etc/openvpn/easy-rsa/
source vars
KEY_CN=$CN ./pkitool $CN
mkdir $CN

#Creation du fichier de configuration
cat "$LIENSCRIPTFOLDER/conf_client" | sed -e "s/{pseudo}/$CN/g" > $CN/$CN.ovpn

cp keys/{ca.crt,$CN.crt,$CN.key,ta.key} $CN/
zip -r $CN.zip $CN
mkdir "$LIENSCRIPTFOLDER/../static/members/$EMAIL/keys/"
mv $CN.zip "$LIENSCRIPTFOLDER/../static/members/$EMAIL/keys/"
cp -R $CN/* "$LIENSCRIPTFOLDER/../static/members/$EMAIL/keys/"
