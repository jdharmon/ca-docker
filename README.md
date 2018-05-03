# Certificate Authority
Simple CA container for creating development certificates based on the [OpenSSL Certificate Authority](https://jamielinux.com/docs/openssl-certificate-authority/) guide.

## Usage

On first run a CA certificate will be generated for you. 

The default CA key password is "secret". You may specify a custom password by passing ```-e PASSWORD=mypassword``` to run.

### Create New Certificate
```docker run -it --rm -v ${PWD}:/ca jdharmon/ca create server|usr <certname>```

### Export Certificate to .pfx
```docker run -it --rm -v ${PWD}:/ca jdharmon/ca export <certname>```

### Run Arbitrary Command
```docker run -it --rm -v ${PWD}:/ca jdharmon/ca run <command>```
