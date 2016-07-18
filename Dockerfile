FROM alpine:3.3

EXPOSE 8443
RUN adduser -D user
VOLUME /home/user

# To update browse https://build.syncthing.net/job/stdiscosrv/
ENV version v0.14.0-rc.1
ENV jenkins_build 1751

RUN set -x \
 && apk --no-cache --virtual .temp_del add ca-certificates \
 && tarball="stdiscosrv-linux-amd64-${version}.tar.gz" \
 && dir="$(basename "$tarball" .tar.gz)" \
 && bin="$dir/stdiscosrv" \
 && url="https://build.syncthing.net/job/stdiscosrv/${jenkins_build}/artifact/${tarball}" \
 && wget -q $url \
 && tar zxvf "$tarball" "$bin" \
 && mv "$bin" /usr/local/bin/stdiscosrv \
 && rm "$tarball" \
 && rmdir "$dir" \
 && apk del .temp_del

USER user
CMD ["stdiscosrv",\
    "-key",          "/cert/key.pem",\
    "-cert",         "/cert/cert.pem",\
    "-limit-avg",    "10",\
    "-limit-cache",  "25000",\
    "-stats-file",   "/home/user/stats"]
