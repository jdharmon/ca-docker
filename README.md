Simple CA container for creating development certificates based on the [OpenSSL Certificate Authority](https://jamielinux.com/docs/openssl-certificate-authority/) guide.

Usage: ```docker run -it --rm -v /path/to/ca:/ca jdharmon/ca create server|usr <certname>```

On first run a CA certificate will be generated for you. Default key password is "secret".

