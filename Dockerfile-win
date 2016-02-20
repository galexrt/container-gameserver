FROM fedora:23
MAINTAINER Alexander Trost <galexrt@googlemail.com>

ENV DATA_PATH="/data"

ADD entrypoint-win.sh /entrypoint.sh

RUN dnf -q upgrade -y && \
    dnf install curl ca-certificates glibc.i686 libstdc++.i686 python python-dev \
        curl wine xvfb && \
    curl -sS https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -o /usr/local/bin/winetricks && \
    chmod +x /usr/local/bin/winetricks && \
    dnf clean all && \
    rm -rf /var/lib/dnf/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/locale/*

VOLUME ["$DATA_PATH"]
WORKDIR "$DATA_PATH"

ENTRYPOINT ["/bin/sh"]
