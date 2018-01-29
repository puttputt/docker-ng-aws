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
    pip install awsebcli --upgrade --user && \
    apk add --update dumb-init && \
    apk add --update nodejs nodejs-npm && \
    apk add mysql mysql-client && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/* && \
    chown -R $(whoami) /usr/lib /usr/local/share /usr/local/bin  && \
    npm -g config set user root && \
    npm install -g @angular/cli && \
    npm cache clean --force && \
    /usr/bin/mysql_install_db --user=mysql  && \
    chown -R mysql /var/lib/mysql

# RUN /usr/bin/mysqld_safe --datadir='/var/lib/mysql' --user=mysql &
# RUN /usr/bin/mysqladmin -u root password 'password'
WORKDIR /tmp

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
