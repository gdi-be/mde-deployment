FROM debian:bookworm

RUN apt update && apt -y install samba krb5-config winbind smbclient iproute2 openssl vim && apt clean

RUN rm /etc/krb5.conf
RUN mkdir -p /opt/ad-scripts

WORKDIR /opt/ad-scripts

CMD chmod +x *.sh && ./samba-ad-setup.sh && ./samba-ad-run.sh
