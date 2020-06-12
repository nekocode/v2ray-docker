内置应用版本号:

- caddy: `2.0.0`
- v2ray: `v4.24.2`

使用方法:

```
docker pull nekocode/v2ray:latest

# 将下面的 YOUR_DOMAIN 替换成已经解析到你服务器的域名:
docker run -d -p 80:80 -p 443:443 -e DOMAIN=YOUR_DOMAIN nekocode/v2ray:latest
```

容器启动后访问你的域名，会得到以下页面：

<img src="screenshot.jpg" width="400">
