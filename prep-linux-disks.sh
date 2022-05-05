for LUN in $(ls /dev/disk/azure/scsi1)
do 
    NUM=$(echo $LUN | grep -o -E "[0-9]+")
    if [ -d "/data${NUM}" ]
    then
        echo "Disk Exists"
    else
        echo "y" | mkfs.ext4 /dev/disk/azure/scsi1/${LUN}
        mkdir /data${NUM}
        echo "/dev/disk/azure/scsi1/${LUN} /data${NUM} ext4 defaults,nofail 0 0" >>/etc/fstab
    fi
done

mount -a

