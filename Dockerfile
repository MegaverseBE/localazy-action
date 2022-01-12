FROM ubuntu:latest

RUN apt-get update -y && apt-get install wget gnupg jq -y
RUN wget -qO - https://dist.localazy.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb [arch=amd64] https://maven.localazy.com/repository/apt/ stable main" | tee /etc/apt/sources.list.d/localazy.list
RUN apt-get update && apt-get install localazy -y

COPY entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh 

ENTRYPOINT ["/entrypoint.sh"]
