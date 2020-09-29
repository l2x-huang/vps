
## 添加/删除swap

``` sh
## 添加2G的swap
$ wget -qO- https://github.com/l2x-huang/vps/blob/master/swap.sh | \
    sudo bash - -a -s 2G
## 删除swap
$ wget -qO- https://github.com/l2x-huang/vps/blob/master/swap.sh | \
    sudo bash - -d
```

`
