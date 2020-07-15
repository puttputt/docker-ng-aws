FROM alpine:latest

LABEL maintainer="enginering@joinoffstreet.com"

ENV NODE_OPTIONS=--max_old_space_size=4096

RUN apk update && \
    apk upgrade && \
    apk -v --update add \
        python3-dev \
        py-pip \
        groff \
        less \
        mailcap \
        py-setuptools \
        build-base \ 
        libressl-dev \
        musl-dev \
        libffi-dev \
        py3-botocore && \
    pip3 install --upgrade setuptools && \
    pip3 install --upgrade awscli==1.18.34 --ignore-installed six && \
    pip3 install --upgrade awsebcli --ignore-installed six && \
    apk add --update git && \
    apk add --update dumb-init && \
    apk add --update nodejs nodejs-npm && \
    apk add mysql mysql-client && \
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
