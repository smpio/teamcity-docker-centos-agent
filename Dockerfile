FROM centos:7

RUN yum install -y java-1.8.0-openjdk-headless && \
    yum clean all -y
ENV JAVA_HOME /usr/lib/jvm/jre

ENV TEAMCITY_VERSION 2017.1.2
ENV TEAMCITY_DISTFILE TeamCity-${TEAMCITY_VERSION}.tar.gz
ENV TEAMCITY_PREFIX /opt

WORKDIR $TEAMCITY_PREFIX
RUN curl -sSLO https://download.jetbrains.com/teamcity/$TEAMCITY_DISTFILE && \
    tar -xf $TEAMCITY_DISTFILE TeamCity/buildAgent && \
    rm $TEAMCITY_DISTFILE && \
    mv TeamCity/buildAgent buildagent && \
    rmdir TeamCity

RUN curl -sSL https://github.com/JetBrains/teamcity-docker-minimal-agent/raw/master/run-agent.sh -o /run-agent.sh && \
    sed -i s/conf_dist/conf/g /run-agent.sh && \
    chmod +x /run-agent.sh && \
    mkdir -p /data/teamcity_agent/conf

EXPOSE 9090

ENV DOCKER_VERSION 17.03.1.ce-1.el7.centos
RUN yum install -y yum-utils && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install -y docker-ce-$DOCKER_VERSION

RUN yum install -y git

RUN yum clean all

COPY run.sh /
CMD ["/run.sh"]
