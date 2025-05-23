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

## Keycloak user federation

To configure the keycloak user federation pointing to a AD instance:

* if the certificate of the AD is self signed, import the certificate into the keycloak cacerts keystore using `keytool -import -file /tmp/cert -alias ad -keystore cacerts`. Make sure the cacerts file is mounted as a volume to the proper location:
```
    volumes:
      - ./mde-keycloak/cacerts:/etc/pki/ca-trust/extracted/java/cacerts:rw,U
```
* if the certificate of the AD does not include the name of the hostname where it is running, make sure to add `-Dcom.sun.jndi.ldap.object.disableEndpointIdentification=true` to the keycloak start command in the compose file
* when adding the user federation make sure you point to the ad using an ldaps:// URL
* use credentials like `CN=Administrator,CN=Users,DC=dc,DC=internal` (with the proper password) to authenticate
* make sure to configure the correct user DN (e.g. CN=Users,DC=dc,DC=internal)
* add the `role-ldap-mapper` and configure the ldap roles DN (e.g. CN=Users,DC=dc,DC=internal)
* add a `user-attribute-ldap-mapper` for the fields `streetAddress`, `telephoneNumber`, `givenName`, `sn`, `mail`, `company` and `l` and add these attributes to the keycloak user model (in case they don't exist). Map `givenName` to `firstName`, `sn` to `lastName`, `l` to `city` and `mail` to `email`

## Troubleshooting

> Metadata is visible in the overview but can't be found in the MetadataSearchField (e.g. Neuerfassung -> Vorlage):

Probably the search index was not created/updated correctly. You can trigger a manula update of the search index by opening /search/index/initialize as a logged in user. This will trigger a full reindex of all metadata.
