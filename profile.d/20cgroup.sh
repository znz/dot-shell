#!/bin/sh

# see http://www.webupd8.org/2010/11/alternative-to-200-lines-kernel-patch.html
#
# /etc/rc.local:
# mkdir -p /sys/fs/cgroup/cpu
# mount -t cgroup cgroup /sys/fs/cgroup/cpu -o cpu
# mkdir -m 0777 /sys/fs/cgroup/cpu/user
#
# Ubuntu (lucid):
# /etc/rc.local:
# mkdir -p /dev/cgroup/cpu
# mount -t cgroup cgroup /dev/cgroup/cpu -o cpu
# mkdir -m 0777 /dev/cgroup/cpu/user
# echo "/usr/local/sbin/cgroup_clean" > /dev/cgroup/cpu/release_agent
#
# /usr/local/sbin/cgroup_clean:
# #!/bin/sh
# rmdir /dev/cgroup/cpu/$*

if [ -d /dev/cgroup/cpu/user ]; then
    mkdir -p -m 0700 /dev/cgroup/cpu/user/$$ > /dev/null 2>&1
    echo $$ >| /dev/cgroup/cpu/user/$$/tasks
    echo "1" >| /dev/cgroup/cpu/user/$$/notify_on_release
elif [ -d /sys/fs/cgroup/cpu/user ]; then
    mkdir -m 0700 /sys/fs/cgroup/cpu/user/$$
    echo $$ >| /sys/fs/cgroup/cpu/user/$$/tasks
fi
