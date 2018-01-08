FROM alpine

MAINTAINER offstreet technology inc. "info@offstreet.ca"

RUN apk -v --update add \
        python \
        py-pip \
        groff \
        less \
        mailcap \
        && \
    pip install --upgrade awscli && \
    apk add --update dumb-init && \
    apk add --update nodejs nodejs-npm && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/* && \
    chown -R $(whoami) /usr/lib /usr/local/share /usr/local/bin  && \
    npm -g config set user root && \
    npm install -g @angular/cli && \
    npm cache clean --force
WORKDIR /tmp

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
