#!/bin/sh

new_ca () {
	echo "*** Creating CA ***"
	echo
	mkdir certs crl newcerts private
	touch index.txt
	echo 1000 > serial
	openssl req -new -x509 -extensions v3_ca -out cacert.crt -keyout private/cakey.key
}

#Check for existing CA
if [ ! -f index.txt ]; then
    new_ca
fi

#Run CMD
$1