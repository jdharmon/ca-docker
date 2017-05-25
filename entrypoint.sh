#!/bin/sh

echo $1

new_ca () {
	echo "*** Creating CA ***"
	mkdir certs crl newcerts private
	touch index.txt
	echo 1000 > serial
	openssl req -new -out cacert.csr -keyout private/cakey.pem
	echo "*** Signing CA ***"
	openssl ca -selfsign -in cacert.csr -out cacert.pem -extensions v3_ca
	rm cacert.csr
}

if [ ! -f /index.txt ]; then
    new_ca
fi

#Run CMD
$1