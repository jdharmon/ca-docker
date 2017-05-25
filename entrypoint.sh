#!/bin/sh

echo $1

new_ca () {
	echo "*** Creating CA ***"
	mkdir certs crl newcerts private
	touch index.txt
	echo 1000 > serial
	openssl req -new -x509 -extensions v3_ca -out cacert.pem -keyout private/cakey.pem 
}

if [ ! -f /index.txt ]; then
    new_ca
fi

#Run CMD
$1

