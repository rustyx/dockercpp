FROM debian:latest

RUN apt-get update && apt-get install -y openssh-server g++ make cmake
RUN cat /dev/zero | ssh-keygen -q -t rsa -N ""
RUN mkdir /var/run/sshd
RUN echo 'root:develop' | chpasswd
RUN echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIBKysvsiJLY68sDeu+9IcDPHFrlhQbrQli8E2emxcX95QW68DXxJRz3SYFyjrMAa+VdsSRtUhCjeh/0+Di5eGh/\
ovMFr+L1NPwqmQbfEjlwk6hDYh+nOuv5WRdhH6qrR9N3i2J1RT+RVSGfviopq9M+8TA9ejxzX1nA2diixdkcGQ== rsa-key-20070522' >/root/.ssh/authorized_keys
RUN sed -i -e 's/PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN cat /dev/null > /etc/motd
#RUN echo "export SAMPLE=sample" >> /etc/profile
COPY /entrypoint.sh ./

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
