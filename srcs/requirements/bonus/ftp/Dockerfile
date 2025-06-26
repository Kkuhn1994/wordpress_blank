FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    pure-ftpd \
    ftp

RUN mkdir -p /home/kkuhn/www \
    && chown -R nobody:nogroup /home/kkuhn/www \
    && chmod -R 755 /home/kkuhn/www



ENTRYPOINT ["pure-ftpd", "-P", "0.0.0.0", "-j", "-l", "unix", "-p", "30000:30010"]
