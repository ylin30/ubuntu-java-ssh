# Base Ubuntu Precise 12.04 LTS image
# Add Openjdk dependency for Linux 3.8.0-38-generic x86_64
# Add sshd supports
FROM ubuntu:precise
MAINTAINER ylin  ylin30@gmail.com

# Openjdk dependency
# Ref: http://superuser.com/questions/478284/dependencies-problems-installing-openjdk-on-ubuntu
#ADD http://160.26.2.181/ports/pool/main/t/tzdata/tzdata-java_2013g-0ubuntu0.12.04_all.deb /root/tzdata-java_2013g-0ubuntu0.12.04_all.deb
#ADD http://security.ubuntu.com/ubuntu/pool/main/t/tzdata/tzdata-java_2015g-0ubuntu0.12.04_all.deb /root/tzdata-java_2015g-0ubuntu0.12.04_all.deb
#RUN dpkg -i /root/tzdata-java_2015g-0ubuntu0.12.04_all.deb && rm /root/tzdata-java_2015g-0ubuntu0.12.04_all.deb

# install a few other useful packages plus Open Jdk 7
RUN apt-get update && apt-get upgrade -y && apt-get install -y less openjdk-7-jre-headless net-tools vim-tiny sudo openssh-server iputils-ping

ADD files /root/ssh_files

RUN mkdir /root/.ssh
RUN chmod go-rx /root/.ssh
RUN mkdir /var/run/sshd

RUN cp /root/ssh_files/* /root/.ssh
RUN chmod go-rwx /root/.ssh/id_rsa
RUN chmod go-wx /root/.ssh/authorized_keys

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 TERM=xterm-256color
RUN sudo apt-get install -y telnet
