FROM ubuntu:14.04

MAINTAINER EduFich <edumoliva@hotmail.com>

RUN apt-get update
RUN apt-get install -y apache2
RUN apt-get install -y php5 php5-common php5-cli php5-mysql php5-curl 

# Install base packages
RUN DEBIAN_FRONTEND=noninteractive \
    dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
      libxt6 \
      libxmu6 \
      libxp6 \
      libxtst6 \
      build-essential \
      gfortran \
      gcc \
      g++ \
      libc6:i386 libncurses5:i386 libstdc++6:i386 \
      imagemagick \
      ghostscript \
      xorg && \
    rm -rf /var/lib/apt/lists/*


VOLUME /var/www/html
COPY grnnminer /var/www/html/

# Create a new user "developer".
# It will get access to the X11 session in the host computer

ENV uid=1000
ENV gid=${uid}

COPY create_user.sh /
COPY run.sh /


EXPOSE  80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]


