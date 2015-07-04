FROM fedora:22
RUN dnf update -y 
ENV container docker

RUN dnf install -y -q systemd perl-Params-Validate perl-Nagios-Plugin nrpe nagios-plugins nagios-plugins-all uptimed;  \
  (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
  rm -f /lib/systemd/system/multi-user.target.wants/*;\
  rm -f /etc/systemd/system/*.wants/*;\
  rm -f /lib/systemd/system/local-fs.target.wants/*; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -f /lib/systemd/system/basic.target.wants/*;\
  rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN systemctl enable nrpe.service
RUN sed -e 's/^allowed_hosts=127.0.0.1/#allowed_hosts=127.0.0.1/' -i /etc/nagios/nrpe.cfg
ADD check_mem /usr/lib64/nagios/plugins/check_mem 
ADD tweak.cfg /etc/nrpe.d/tweak.cfg

EXPOSE 5666
CMD ["/usr/sbin/init"]
