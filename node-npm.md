# Node NPM Commands


## Fix Error: ENFILE: file table overflow

```
echo kern.maxfiles=65536 | sudo tee -a /etc/sysctl.conf
echo kern.maxfilesperproc=65536 | sudo tee -a /etc/sysctl.conf
sudo sysctl -w kern.maxfiles=65536
sudo sysctl -w kern.maxfilesperproc=65536
ulimit -n 65536
```

## Force lock update

``` bash
rm -rf node_modules
npm install --save-dev xxx@a.b.c
npm install
```

## Update Package Lock

> `cnpm` does not support lock.

```
npm --registry=https://registry.npm.taobao.org i
```
