FROM alpine:latest
LABEL shencangsheng <shencangsheng@126.com>

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash unzip zip wget openjdk8

ENV GRAILS_VERSION 4.0.12

# ENV GRADLE_VERSION 5.6.4

# Install Gradle
RUN apk add --no-cache gradle
# WORKDIR /root/.gradle/wrapper/dists/gradle-5.6.4-bin/bxirm19lnfz6nurbatndyydux
# RUN wget https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip

# Install Grails
WORKDIR /usr/lib/jvm
RUN wget https://github.com/grails/grails-core/releases/download/v$GRAILS_VERSION/grails-$GRAILS_VERSION.zip && \
    unzip grails-$GRAILS_VERSION.zip && \
    rm -rf grails-$GRAILS_VERSION.zip && \
    ln -s grails-$GRAILS_VERSION grails

# Setup Grails path.
ENV GRAILS_HOME /usr/lib/jvm/grails
ENV PATH $GRAILS_HOME/bin:$PATH

# Create App Directory
RUN mkdir /app

# Set Workdir
WORKDIR /app

# Set Default Behavior
# ENTRYPOINT ["grails"]