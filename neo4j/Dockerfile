FROM eclipse-temurin:25-noble

ARG neo4j_version=2026.04.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                       sudo \
                       adduser \
                       unzip \
                       curl \
                       wget \
                       ca-certificates \
                       gnupg2 \
                       vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://debian.neo4j.com/neotechnology.gpg.key | gpg --dearmor -o /etc/apt/keyrings/neotechnology.gpg > /dev/null \
    && chmod +r /etc/apt/keyrings/neotechnology.gpg \
    && echo 'deb [signed-by=/etc/apt/keyrings/neotechnology.gpg] https://debian.neo4j.com stable latest' | sudo tee -a /etc/apt/sources.list.d/neo4j.list > /dev/null \
    && apt-get update \
    && apt-get install -y --no-install-recommends neo4j=1:${neo4j_version} \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN perl -wpi -e 's!\#(server.default_listen_address=.+)!$1!' /etc/neo4j/neo4j.conf

RUN echo "Defaults:neo4j !requiretty" >> /etc/sudoers.d/neo4j \
    && echo "neo4j ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/neo4j \
    && chmod 440 /etc/sudoers.d/neo4j

USER neo4j

ENV NEO4J_CONF=/etc/neo4j
ENV NEO4J_HOME=/var/lib/neo4j

ENTRYPOINT ["/usr/share/neo4j/bin/neo4j", "console"]
