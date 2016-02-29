FROM java:8

EXPOSE 8080

RUN apt-get update && \
    apt-get install -y tomcat8 ant git sudo && \
    cd /opt && \
    git clone https://github.com/w3c/css-validator && \
    cd css-validator && \
    ant war && \
    rm -rf /var/lib/tomcat8/webapps/ROOT && \
    sudo -u tomcat8 cp css-validator.war /var/lib/tomcat8/webapps/ROOT.war

# Note.
# docker run --cap-add SYS_PTRACE
ENTRYPOINT service tomcat8 start && tailf /dev/null
