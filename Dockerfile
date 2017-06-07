FROM alpine
RUN apk update \
 && apk add openssl
COPY openssl.cnf /etc/ssl/
COPY entrypoint.sh /bin
WORKDIR /ca
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["/bin/sh"]
ENV PASSWORD=secret