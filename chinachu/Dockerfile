FROM node:14-buster AS build

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN git clone --depth 1 https://github.com/Chinachu/Chinachu.git /usr/local/chinachu

WORKDIR /usr/local/chinachu
RUN echo 2 | ./chinachu installer \
    && echo 4 | ./chinachu installer \
    && ./chinachu service operator initscript > /etc/init.d/chinachu-operator \
    && ./chinachu service wui initscript > /etc/init.d/chinachu-wui \
    && chmod u+x /etc/init.d/chinachu-operator /etc/init.d/chinachu-wui


FROM jrottenberg/ffmpeg:4.4-vaapi

ENV DOCKER=YES
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
WORKDIR /usr/local/chinachu

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl tzdata jq \
    && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /etc/init.d/chinachu-* /etc/init.d/
COPY --from=build /usr/local/chinachu/ /usr/local/chinachu/
COPY services.sh /usr/local/bin/
COPY recordedCommand.sh /usr/local/bin/
COPY config/config.json /usr/local/chinachu/

ENTRYPOINT []
CMD [ "/usr/local/bin/services.sh" ]
EXPOSE 10772 20772 5353
