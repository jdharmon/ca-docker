# Certificate Authority
Simple CA container for creating development certificates based on the [OpenSSL Certificate Authority](https://jamielinux.com/docs/openssl-certificate-authority/) guide.

## Usage

On first run a CA certificate will be generated for you. 

#### Passwords
The default CA key password is "secret". You may specify a custom password by passing ```-e PASSWORD=mypassword``` to run.

You may specify ```-e NO_PASSWORD=Y``` to create private keys without a password. The CA key will still have a password. 

#### Subject Alternate Name (SAN)
OpenSSL does not support supplying a SAN interactively. You may specify the ```SAN``` environment variable: 
```-e SAN='DNS:host, IP:127.0.0.1'```

### Create New Certificate
```docker run -it --rm -v ${PWD}:/ca jdharmon/ca create server|usr <certname>```

### Create New Self-Signed Certificate
```docker run -it --rm -v ${PWD}:/ca jdharmon/ca create self <certname>```

### Export Certificate to .pfx
```docker run -it --rm -v ${PWD}:/ca jdharmon/ca export pfx <certname>```

### Run Arbitrary Command
```docker run -it --rm -v ${PWD}:/ca jdharmon/ca run <command>```
