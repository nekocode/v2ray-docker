#!/bin/sh -v

docker build -t nekocode/v2ray:latest .

# Test
# docker rm -f test-v2ray
# docker run -d -p 80:80 -p 443:443 -e DOMAIN=localhost --name test-v2ray nekocode/v2ray:latest
