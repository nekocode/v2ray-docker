versions:
- caddy: `2.0.0`
- v2ray: `v4.24.2`

usage:

```
docker pull nekocode/v2ray:latest

# Replace the YOUR_DOMAIN below:
docker run -d -p 80:80 -p 443:443 -e DOMAIN=YOUR_DOMAIN nekocode/v2ray:latest
```