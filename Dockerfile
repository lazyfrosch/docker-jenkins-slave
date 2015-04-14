FROM lazyfrosch/ubuntu:trusty
MAINTAINER Markus Frosch <markus.frosch@lazyfrosch.de>

RUN apt-get install -y openjdk-6-jdk build-essential git openssh-server

RUN \
  adduser --uid 9100 --ingroup nogroup --gecos "Jenkins Slave" --home /home/jenkins --disabled-password jenkins \
  && mkdir /home/jenkins/.ssh \
  && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNZZneb4rXp2IayQVHcAEQP/WVWOPg1QAhEeMmirwgAYA/LW4DPSJgSjN+xZauuowMD/qIOns7lKnGBz53KvqF4Nr3yYNGepVrURYha3/K96VkFl66Zux/xORQlk7qjFIICFZTPxJIpmI3AAF+Vp5laaPv2RzgVB2C6l/qiAw6nhysf4NRuo9H9Mfr6oFgwSw5xRN98sZ1YTVTsLHuLU7KmIRs0ReLbs/IpeektJixMgA+PumFc7h+1VVdrmEraW4IP2c/WBiHBSSpbLONid4BddX2SSA9FC9vcyPCjs6XDlR4EEFE0VWSdWeFyqitzPqGDPWo9dzjRVEcQXHvs5ITJDeYKTUI3B1a/tgxc+wblD4faxkLiuuIuL/nAWDOgIWbS69fgJ1tXrvgPWGsPW6pxWAQi0kZ+wUXAZ+wpPHgTrGqstnLzd4+SMtde8+htSz7HGClTKpDMTI+WMjwgxm/GUfWKnk0tuN3xAnhmYBV8J7d6IiL8xe2k44iS2uj451ceAKhRH9eVYtg/QWpbCWDbuYNBsHV9mDm8Z+oVLdQMaFCjxwd3q6p6cI6YomcqTZal+QwIaE4F0ty57V3k+6ShdWNXPil5oBHg6RduULwstJ2/651YXXJo3XqPeFXUfSfy7J8o+MG0EVQiPiWeqCKwvPUgplfyZrRf9aHAj7c/Q== Jenkins Docker Slave" \
    > /home/jenkins/.ssh/authorized_keys \
  && chown -R jenkins.nogroup /home/jenkins/.ssh \
  && chmod g=,o= -R /home/jenkins/.ssh

RUN mkdir -p /var/run/sshd && sed -i 's/^.*\(loginuid\|motd\)/#\0/' /etc/pam.d/sshd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
