#!/bin/bash
set -eo pipefail

if [[ -z $DOMAIN ]]; then
  echo "DOMAIN 不能为空"
  exit 1
fi

if [[ -z $UUID ]]; then
  UUID="$(uuidgen)"
fi

echo "DOMAIN 为 \"${DOMAIN}\""
echo "UUID 为 \"${UUID}\""

set -x

# 配置 caddy
cp -f /caddy/.config.json  /caddy/config.json
sed -i "s/DOMAIN/${DOMAIN}/" /caddy/config.json

# 修改 html
cp -f /caddy/html/.index.html /caddy/html/index.html
sed -i "s/DOMAIN/${DOMAIN}/" /caddy/html/index.html
sed -i "s/UUID/${UUID}/" /caddy/html/index.html

# 配置 v2ray
cp -f /v2ray/.config.json /v2ray/config.json
sed -i "s/UUID/${UUID}/" /v2ray/config.json
cat /v2ray/config.json

# 配置 v2ray logrotate
cat >/etc/logrotate.d/v2ray <<'EOF'
/v2ray/logs/*.log {
  daily
  size 50M
  missingok
  rotate 5
  compress
  delaycompress
  notifempty
  copytruncate
}
EOF

# 启动 caddy 和 v2ray
forego start
