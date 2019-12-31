FROM node:12-buster AS build

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
    && apt-get -y --no-install-recommends install libpcsclite-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://github.com/stz2012/libarib25/archive/09770e3.tar.gz | tar zxv \
    && cd libarib25-09770e334837f6c67268c41c1c15784373d35e5b \
    && make \
    && make install \
    && rm -rf libarib25-09770e334837f6c67268c41c1c15784373d35e5b

WORKDIR /usr/local/src
RUN curl -sL http://www13.plala.or.jp/sat/recdvb/recdvb-1.3.2.tgz | tar zxv \
    && cd recdvb-1.3.2 \
    && ./autogen.sh \
    && ./configure --enable-b25 \
    && make \
    && make install \
    && rm -rf recdvb-1.3.2

RUN npm install -g pm2 \
    && npm install mirakurun -g --unsafe-perm --production


FROM node:12-buster-slim
WORKDIR /usr/local/lib/node_modules/mirakurun
ENV DOCKER=YES

RUN apt-get update \
    && apt-get -y --no-install-recommends install libpcsclite-dev tzdata \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/lib/libarib25.so.0.2.5 /usr/local/lib/
RUN ldconfig -v

COPY --from=build /usr/local/bin/b25 /usr/local/bin/
COPY --from=build /usr/local/bin/recdvb* /usr/local/bin/
COPY --from=build /usr/local/lib/node_modules/mirakurun /usr/local/lib/node_modules/mirakurun
COPY config/ /usr/local/etc/mirakurun/

CMD [ "npm", "start" ]
EXPOSE 40772 41772
