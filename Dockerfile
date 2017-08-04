FROM alpine
COPY openssl.cnf /etc/ssl/
COPY entrypoint.sh /bin
RUN chmod +x /bin/entrypoint.sh \
 && apk update \
 && apk add openssl
WORKDIR /ca
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["/bin/sh"]
ENV PASSWORD=secret
