FROM centos:7

RUN yum install -y java-1.8.0-openjdk-headless && \
    yum clean all -y

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
    chmod +x /run-agent.sh

CMD ["/run-agent.sh"]
EXPOSE 9090
