FROM caddy:2.0.0-alpine
LABEL maintainer "nekocode <nekocode.cn@gmail.com>"

# Install necessary libs
RUN apk add --no-cache bash logrotate curl tar util-linux

# Install forego
ARG FOREGO_VERSION="ekMN3bCZFUn"
RUN curl "https://bin.equinox.io/c/${FOREGO_VERSION}/forego-stable-linux-amd64.tgz" -Lo /tmp/forego.tgz
RUN cd /usr/local/bin && tar -xzf /tmp/forego.tgz \
    && chmod +x /usr/local/bin/forego \
    && rm /tmp/forego.tgz

#
# Install v2ray
#
ARG V2RAY_VERSION="v4.24.2"
ARG TZ="Asia/Shanghai"
ENV TZ ${TZ}
RUN mkdir -p /tmp/v2ray \
    && curl "https://github.com/v2ray/v2ray-core/releases/download/${V2RAY_VERSION}/v2ray-linux-64.zip" -Lo /tmp/v2ray/v2ray.zip \
    && unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray/
RUN mv /tmp/v2ray/v2ray /usr/bin \
    && mv /tmp/v2ray/v2ctl /usr/bin \
    && chmod +x /usr/bin/v2ray \
    && chmod +x /usr/bin/v2ctl \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && rm -rf /tmp/v2ray /var/cache/apk/*

# Copy files
COPY ./main.sh /
COPY ./Procfile /
COPY ./caddy/ /caddy/
COPY ./v2ray/ /v2ray/

EXPOSE 80 443

ENTRYPOINT ["/main.sh"]
