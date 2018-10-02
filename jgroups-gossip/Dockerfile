FROM java:8

ARG jgroups_version=4.0.13.Final

RUN apt-get update -y && \
    apt-get install -y sudo \
                       wget \
                       curl \
                       vim && \
    apt-get clean

RUN adduser --disabled-login --gecos '' jgroups && \
    usermod -G sudo jgroups

RUN echo "Defaults:jgroups !requiretty" >> /etc/sudoers.d/jgroups && \
    echo "jgroups ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/jgroups && \
    chmod 440 /etc/sudoers.d/jgroups

RUN mkdir /opt/jgroups && \
          cd /opt/jgroups && \
          wget -q https://search.maven.org/remotecontent?filepath=org/jgroups/jgroups/${jgroups_version}/jgroups-${jgroups_version}.jar -O jgroups-${jgroups_version}.jar && \
          mv jgroups-${jgroups_version}.jar jgroups.jar

WORKDIR /opt/jgroups

USER jgroups

EXPOSE 12001

ENTRYPOINT ["java", "-cp", "jgroups.jar", "org.jgroups.stack.GossipRouter"]
