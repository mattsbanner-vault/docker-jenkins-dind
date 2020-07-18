FROM jenkins/jenkins:latest

LABEL maintainer = "Matt Banner <matt@banner.wtf>"

USER root

RUN apt-get update && \
    apt-get -y install apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
      $(lsb_release -cs) \
      stable" && \
   apt-get update && \
   apt-get -y install docker-ce && \
   apt-get remove -y --purge software-properties-common && \
   apt-get -y autoremove && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/*
