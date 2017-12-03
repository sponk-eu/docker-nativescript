FROM node:8.9.1

MAINTAINER Maciej Pochroń "maciejpochron@sponk.pl"

RUN npm install yarn -g && npm install -g --unsafe-perm nativescript

RUN \
  apt-get update && \
  apt-get install -y software-properties-common curl git htop man wget make python g++ \
	lib32stdc++6 lib32z1 lib32ncurses5 g++ ant make

RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# download and extract android sdk
RUN curl http://dl.google.com/android/android-sdk_r23.0.1-linux.tgz | tar xz -C /usr/local/
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# update and accept licences
RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | /usr/local/android-sdk-linux/tools/android update sdk --no-ui -a --filter platform-tool,build-tools-23.0.1,android-22,extra-android-m2repository

#RUN npm -v
#RUN npm install nativescript -g

#ENV GRADLE_USER_HOME /src/gradle

VOLUME /src
WORKDIR /src
