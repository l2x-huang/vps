
## 添加/删除swap

``` sh
## 添加2G的swap
$ wget -qO- https://raw.githubusercontent.com/l2x-huang/vps/master/swap.sh | \
        sudo bash -s -- -a -s 2G
## 删除swap
$ wget -qO- https://raw.githubusercontent.com/l2x-huang/vps/master/swap.sh | \
        sudo bash -s -- -d
```

`
