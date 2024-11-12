## Setup dev environment

* clone all repositories in the group https://code.terrestris.de/gdi-berlin/mde , ideally into a single directory
* install podman and podman-compose
* add the line `net.ipv4.ip_unprivileged_port_start=80` to `/etc/sysctl.conf` and run `sysctl --system`
* run `sudo chown -R 999:999 logs` and `sudo chown -R 1000:1000 esdata-public`
* manually add an admin user in keycloak by changing into the container, cd to `/opt/keycloak/bin` and running `./kc.sh bootstrap-admin user`
