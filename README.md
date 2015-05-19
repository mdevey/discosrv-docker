discosrv
========

This is the official discovery server image, which is what runs on
announce.syncthing.net.

To start,

```
docker run -p 22026:22026/udp --restart=always syncthing/discosrv &
```

The container will be automatically restarted on boot or if the
discovery server crashes for whatever reason. The database and
statistics are stored in a volume on `/home/discosrv`, which can be
inspected from another container if necessary.

