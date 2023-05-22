#!/bin/bash

cd /home/ymj/Desktop/TUP-InfantryVision-2022/build
source /opt/intel/openvino_2021/bin/setupvars.sh
./run
while true; do
    # 检查是否存在名为 "run" 的进程
    if pgrep run >/dev/null 2>&1 ; then
        sleep 1
    else
        echo "Process is not running. Restarting..."
        #make clean && make -j6
        make -j6
        gnome-terminal -- bash -c "./run; exec bash;"
        # 在这里添加你需要执行的命令，比如重启你的程序
    fi

    # 检查系统日志以查看是否有段错误（SIGSEGV）发生
    if dmesg | grep -q "run.*\[sig\]"; then
        echo "Segmentation fault detected. Restarting..."
#        make clean && make -j6
        make -j6
        gnome-terminal -- bash -c "./run; exec bash;"
        # 在这里添加你需要执行的命令，比如重启你的程序
    fi
done
