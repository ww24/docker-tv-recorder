FROM node:12.13.1-buster AS build

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN git clone --depth 1 git://github.com/kanreisa/Chinachu.git /usr/local/chinachu

WORKDIR /usr/local/chinachu
RUN echo 2 | ./chinachu installer \
    && echo 4 | ./chinachu installer \
    && ./chinachu service operator initscript > /etc/init.d/chinachu-operator \
    && ./chinachu service wui initscript > /etc/init.d/chinachu-wui \
    && chmod u+x /etc/init.d/chinachu-operator /etc/init.d/chinachu-wui

RUN curl https://download.docker.com/linux/static/stable/x86_64/docker-18.09.9.tgz | tar xzvf - \
    && cp docker/* /usr/local/bin \
    && rm -rf docker


FROM jrottenberg/ffmpeg:4.1-vaapi

ENV DOCKER=YES
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
WORKDIR /usr/local/chinachu

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl tzdata jq \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/bin/docker /usr/local/bin/docker
COPY --from=build /etc/init.d/chinachu-* /etc/init.d/
COPY --from=build /usr/local/chinachu/ /usr/local/chinachu/
COPY services.sh /usr/local/bin/
COPY recordedCommand.sh /usr/local/bin/
COPY config/config.json /usr/local/chinachu/

ENTRYPOINT []
CMD [ "/usr/local/bin/services.sh" ]
EXPOSE 10772 20772 5353
