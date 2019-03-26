#!/bin/sh

set -e

usage() {
	echo "Usage: docker run -it -v /path/to/ca:/ca jdharmon/ca create server|usr|self <certname>"
}

new_ca () {
	echo
	echo "*** Creating CA ***"
	echo
	mkdir certs crl newcerts private
	touch index.txt
	echo 1000 > serial
	openssl req -new -x509 -extensions v3_ca -out cacert.crt -keyout private/cakey.key
}

create_cert() {
	if [ "$1" != "server" ] && [ "$1" != "usr" ] && [ "$1" != "self" ]; then
		usage
		exit 2
	fi
	
	extensions="$1_cert"
	certname=$2
	
	echo
	echo "*** Creating new $1 certificate ***"
	
	if [ "${NO_PASSWORD:-N}" != "N" ]; then
		echo "NO_PASSWORD specified. Output key will not be encrypted!"
		args="-nodes"
	fi

	if [ "$1" == "self" ]; then
		openssl req -new -x509 -sha256 -out certs/$certname.crt -keyout private/$certname.key $args
	else
		openssl req -new -sha256 -out $certname.csr -keyout private/$certname.key $args
		openssl ca -extensions $extensions -in $certname.csr -out certs/$certname.crt
		rm $certname.csr
	fi
	
	echo
	echo "Certificate: certs/$certname.crt"
	echo "Private key: private/$certname.key"
}

export_cert() {
	if [ "$1" == "pfx" ] || [ "$1" == "pkcs12" ]; then
		echo "Exporting $2 to $2.pfx..."
		openssl pkcs12 -export -inkey private/$2.key -in certs/$2.crt -certfile cacert.crt -out certs/$2.pfx
	fi
}

#Check for existing CA
if [ ! -f index.txt ]; then
    new_ca
fi

case "$1" in
	create)
		shift
		create_cert "$@"
		;;
	export)
		shift
		export_cert "$@"
		;;
	run)
		shift
		exec "$@"
		;;
	sh)
		/bin/sh
		;;
	*)
		usage
esac
