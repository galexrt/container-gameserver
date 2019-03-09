FROM fedora:28
LABEL maintainer="Alexander Trost <galexrt@googlemail.com>"

ENV DATA_PATH="/data" TINI_VERSION="v0.18.0"

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

# We are not gpg checking tini as of right now Docker Hub seems to "always" have
# problems reaching the public key infrastructure.
RUN dnf -q upgrade -y && \
    dnf install -y glibc.i686 libstdc++.i686 \
        zlib.i686 libcurl.i686 ncurses-libs.i686 && \
    chmod +x /tini && \
    dnf clean all && \
    rm -rf /var/lib/dnf/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/locale/*

VOLUME ["$DATA_PATH"]
WORKDIR "$DATA_PATH"

ENTRYPOINT ["/tini", "--"]
