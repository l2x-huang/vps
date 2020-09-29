#!/usr/bin/env bash
#
# [参考](https://www.moerats.com/archives/722/)
#
function usage() {
    echo "USAGE:"
    echo -e "\tswap.sh [options]"
    echo -e "\nOPTIONS:"
    echo -e "\t-a: add swapfile"
    echo -e "\t-d: del swapfile"
    echo -e "\t-s: specify the swapfile size (512M, 4G)"
    echo -e "\t-h: help"
    exit 0
}

_op="nil"
_size="2G"

# options
while getopts "ads:h" OPTION; do
    case $OPTION in
        a)
            _op="add"
            ;;
        d)
            _op="del"
            ;;
        s)
            _size="$OPTARG"
            ;;
        h) usage;;
    esac
done

if [ $# -eq 0 ]; then usage; fi

# 查找swap
function info() {
    echo -e "\033[32m$1\033[0m"
}

function warn() {
    echo -e "\033[31m$1\033[0m"
}

function add_swap() {
    grep -q "swapfile" /etc/fstab

    if [ $? -ne 0  ]; then
        info "正在创建swapfile ..."
        fallocate -l $1 /swapfile
        chmod 600 /swapfile
        mkswap /swapfile
        swapon /swapfile
        echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
        info "swap创建成功，详细信息如下:"
        cat /proc/swaps
        cat /proc/meminfo | grep Swap
    else
        warn "swapfile已存在，不执行任何操作"
    fi
}

function del_swap() {
    grep -q "swapfile" /etc/fstab

    if [ $? -eq 0 ]; then
        info "找到swapfile，删除中..."
        sed -i '/swapfile/d' /etc/fstab
        echo "3" > /proc/sys/vm/drop_caches
        swapoff -a
        rm -f /swapfile
        info "swap删除成功"
    else
        warn "未发现swapfile, 不执行任何操作!"
    fi
}

# 权限检测
if [[ $EUID -ne 0 ]]; then
    warn "需要管理员权限!"
    exit 1
fi

# ovz
if [[ -d "proc/vz" ]]; then
    warn "不支持OpenVZ机型"
    exit 1
fi

case $_op in
    "add") add_swap $_size;;
    "del") del_swap ;;
    *) usage ;;
esac
