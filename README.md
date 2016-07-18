stdiscosrv
==========

Docker image of Syncthing Discovery Server running in Alpine linux. Total download &lt; 18mb.

Used instead of announce.syncthing.net
(Action > Settings > Global Discovery Servers > default)

Note: v0.14.0-rc.1 is not compatible with previous versions.

## Via docker only
```
syncthing -generate="~/disco_cert/" #once only
docker run -p 8443:8443 -v ~/disco_cert:/cert --restart=always mdevey/stdiscosrv
```
Example output
```
stdiscosrv v0.14.0-rc.1 (go1.6.2 linux-amd64) unknown-user@lx-buildslave.syncthing.net 2016-07-10 07:23:58
Server device ID is ROSKTQK-G5HL7C3-QWJ3E7Z-NMDU7SD-QL777WE-VTZ7FIK-JA7VON6-ZJ6B22F
```

Take note of the 'Server device ID is XXXXX-XXXXX'.
## Now in each Syncthing Client GUI:
```
Action > Settings > Global Discovery Servers
```
Replace 'default' with https://(ServerAddress):8443/v2/?id=(Server device ID above)<br>
eg https://10.1.2.3:8443/v2/?id=ROSKTQK-G5HL7C3-QWJ3E7Z-NMDU7SD-QL777WE-VTZ7FIK-JA7VON6-ZJ6B22F

## Via docker-compose (easier maintenance)
```
syncthing -generate="~/disco_cert/" #once only
#make it exactly how you want it.
vi docker-compose.yml
  #An example of what you might put in docker.compose.yml
  stdiscosrv:
    image: mdevey/stdiscosrv
    container_name: disco
    ports:
      - 8443:8443
    volumes:
      - ~/disco_cert/:/cert
    restart: always
docker-compose up
```
Example output
```
Starting disco
Attaching to disco
disco  | stdiscosrv v0.14.0-rc.1 (go1.6.2 linux-amd64) unknown-user@lx-buildslave.syncthing.net 2016-07-10
disco  | Server device ID is ROSKTQK-G5HL7C3-QWJ3E7Z-NMDU7SD-QL777WE-VTZ7FIK-JA7VON6-ZJ6B22F
```

The container will be automatically restarted on boot or if the
discovery server crashes for whatever reason. The database and
statistics are stored in a volume on `/home/user`, which can be
inspected from another container if necessary.

