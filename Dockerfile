FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME       /usr/lib/jvm/java-8-oracle
ENV LANG            en_US.UTF-8
ENV LC_ALL          en_US.UTF-8

RUN apt-get update && \
  apt-get install -y --no-install-recommends locales && \
  locale-gen en_US.UTF-8 && \
  apt-get dist-upgrade -y && \
  apt-get --purge remove openjdk* && \
  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
  apt-get update && \
  apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default && \
  apt-get clean all
RUN \
  apt-get install -y maven git libcurl4-openssl-dev cmake build-essential libssl-dev locales && \
  apt-get clean
RUN  cd ~ && git clone  --depth 1  https://github.com/OrdinaryDude/elastic-core-maven.git
RUN  cd ~/elastic-core-maven && mvn package
RUN  cd ~ && git clone  --depth 1 https://github.com/OrdinaryDude/xel_miner.git
RUN  cd ~/xel_miner && cmake . && make
RUN  cd ~/elastic-core-maven && ./pull_miner.sh

EXPOSE 17874 17876 16874 16876
WORKDIR /root/elastic-core-maven
ENTRYPOINT /root/elastic-core-maven/run.sh
