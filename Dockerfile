FROM alpine

LABEL maintainer="info@offstreet.ca"

ENV NODE_OPTIONS=--max_old_space_size=4096

RUN apk -v --update add \
        python \
        py-pip \
        groff \
        less \
        mailcap \
        py-setuptools \
        && \
    pip install --upgrade setuptools && \
    pip install --upgrade awscli && \
    pip install --upgrade awsebcli && \
    apk add --update git && \
    apk add --update dumb-init && \
    apk add --update nodejs nodejs-npm && \
    apk add mysql mysql-client && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/* && \
    chown -R $(whoami) /usr/lib /usr/local/share /usr/local/bin  && \
    npm -g config set user root && \
    npm install -g @angular/cli && \
    npm install -g typescript && \
    npm install -g tslint && \
    npm cache clean --force && \
    /usr/bin/mysql_install_db --user=mysql  && \
    chown -R mysql /var/lib/mysql && \
    export PATH=~/.local/bin:$PATH

WORKDIR /tmp

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
