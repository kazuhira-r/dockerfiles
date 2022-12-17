FROM java:8

EXPOSE 8080

ARG vnu_version=16.1.1

RUN apt-get update \
    && apt-get install -y tomcat8 unzip sudo \
    && cd /opt \
    && mkdir validator-nu \
    && cd validator-nu \
    && wget -q https://github.com/validator/validator/releases/download/${vnu_version}/vnu.war_${vnu_version}.zip \
    && unzip vnu.war_${vnu_version}.zip \
    && rm -rf /var/lib/tomcat8/webapps/ROOT \
    && sudo -u tomcat8 cp dist/vnu.war /var/lib/tomcat8/webapps/ROOT.war

# Note.
# docker run --cap-add SYS_PTRACE
ENTRYPOINT service tomcat8 start && tailf /dev/null
