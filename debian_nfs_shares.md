Install NFS client
```sh
sudo apt update
sudo apt install nfs-common
```

Add NFS to /etc/fstab
```sh
192.168.100.121:/mnt/gold/docs    /docs    nfs    x-systemd.automount,auto,rw,_netdev 0 0
```

To manually mount
```sh
sudo mount -a
```