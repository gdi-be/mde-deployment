## Setup dev environment

* clone all repositories in the group https://code.terrestris.de/gdi-berlin/mde , ideally into a single directory
* install podman and podman-compose
* add the line `net.ipv4.ip_unprivileged_port_start=80` to `/etc/sysctl.conf` and run `sysctl --system`
* run `sudo chown -R 999:999 logs` and `sudo chown -R 1000:1000 esdata-public`
* manually add an admin user in keycloak by changing into the container, cd to `/opt/keycloak/bin` and running `./kc.sh bootstrap-admin user`
* run `./setEnvironment.sh` to prepare keystore for SSL communication during devlopment
* an `.env` file has to be configured. Use `cp ./env.example ./.env` as a starting point.

### Permissions setup/reset

To make sure all mounted volume directories get the correct uid/gid:

* make sure all volume directories exist and belong to your own user
* comment in the `,U` option for all volumes where it is commented out
* start up the compose file once using `podman compose up`
* after startup, stop the containers and comment in the `,U` option again

This will automatically `chown` these host directories so they belong to the user running the container's software.

This can also be used to reset all volumes in case of new permission problems.
