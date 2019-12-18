#cloud-config
package_upgrade: true
disk_setup:
  /dev/sdc:
    layout: true
    overwrite: false
    table_type: 'mbr'
fs_setup:
  - label: jenkins_home
    device: /dev/sdc0
    filesystem: ext4
mounts:
  - [ "/dev/sdc", "/var/jenkins_home" ]

groups:
  - docker
  - jenkins
  - oeadmin
users:
  - name: oeadmin
    gecos: Oe oeadmin
    primary_group: oeadmin
    sudo:
      - ALL=(ALL) NOPASSWD:ALL
    groups: docker
    ssh_authorized_keys:
      - "${oeadmin_ssh_pub_key}"
  - name: jenkins
    gecos: Jenkins user
    primary_group: jenkins
    groups: docker
    home: /var/jenkins_home
    ssh_import_id: None
    lock_passwd: true