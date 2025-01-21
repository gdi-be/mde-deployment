## Setup environment

* clone this repository
* install podman and podman-compose (or podman compose)
* add the line `net.ipv4.ip_unprivileged_port_start=80` to `/etc/sysctl.conf` and run `sysctl --system`
* manually add an admin user in keycloak by changing into the container, cd to `/opt/keycloak/bin` and running `./kc.sh bootstrap-admin user`
* run `./setEnvironment.sh` to prepare keystore for SSL communication during devlopment
* an `.env` file has to be configured. Use `cp ./env.example ./.env` as a starting point.
* copy `.client-env.example` to `.client-env` and adapt the values

### Permissions setup/reset

To make sure all mounted volume directories get the correct uid/gid:

* make sure all volume directories exist and belong to your own user
* comment in the `,U` option for all volumes where it is commented out
* start up the compose file once using `podman compose up`
* after startup, stop the containers and comment in the `,U` option again
* you'll possibly need to `chmod g+w` some of the volume files/directories

This will automatically `chown` these host directories so they belong to the user running the container's software.

This can also be used to reset all volumes in case of new permission problems.
