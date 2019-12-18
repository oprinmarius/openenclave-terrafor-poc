#cloud-config
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
write_files:
  - path: /etc/systemd/system/jenkins-slave.service
    content: |
      [Unit]
      Description=Jenkins JNLP Slave
      Wants=network.target
      After=network.target

      [Service]
      EnvironmentFile=/etc/default/jenkins-slave
      ExecStartPre=/bin/mkdir -p ${JENKINS_RUN}
      ExecStartPre=/bin/chown -R jenkins:jenkins ${JENKINS_RUN}
      ExecStartPre=/bin/bash -c "df -h | grep -q '^/dev/sdb1' && umount --force /dev/sdb1 || echo 'Already umounted'"
      ExecStartPre=/sbin/mkfs.ext4 -F /dev/sdb1
      ExecStartPre=/bin/mkdir -p ${JENKINS_WORKSPACE}
      ExecStartPre=/bin/mount /dev/sdb1 ${JENKINS_WORKSPACE}
      ExecStartPre=/bin/chown jenkins.jenkins ${JENKINS_WORKSPACE}
      ExecStartPre=/usr/bin/wget -q -O ${JENKINS_RUN}/slave.jar ${JENKINS_URL}/jnlpJars/slave.jar
      ExecStart=/usr/bin/java -jar ${JENKINS_RUN}/slave.jar -jnlpUrl ${JENKINS_URL}/computer/${JENKINS_NODE_NAME}/slave-agent.jnlp -secret=${JENKINS_SECRET}
      User=jenkins
      PermissionsStartOnly=true
      LimitNOFILE=8192
      Restart=always
      StartLimitInterval=90
      StartLimitBurst=3

      [Install]
      WantedBy=multi-user.target
  - path: /etc/default/jenkins-slave
    content: |
      JENKINS_RUN=/var/run/jenkins
      JENKINS_WORKSPACE="{{ jenkins_agent_root_dir }}"
      JENKINS_URL="{{ jenkins_url }}"
      JENKINS_NODE_NAME="{{ jenkins_agent_name }}"
      JENKINS_SECRET="{{ node_secret }}"
apt:
  preserve_sources_list: true
  sources:
    docker:
      source: deb [arch=amd64] https://download.docker.com/linux/ubuntu $RELEASE stable
      keyid: 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
package_update: true
package_upgrade: true
package_reboot_if_required: true
packages:
  - docker-ce
  - openjdk-8-jre

runcmd:
  - echo this is working > /root/terraform-test

final_message: "Jenkins Slave is finally up, after $UPTIME seconds"
