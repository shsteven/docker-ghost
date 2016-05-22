FROM mhart/alpine-node:4

ENV VERSION=0.7.9

RUN apk --no-cache add --virtual build-dependencies make gcc g++ python wget ca-certificates \
	&& adduser ghost -D -h /ghost -s /bin/sh \
  && wget -q https://ghost.org/zip/ghost-${VERSION}.zip -O /tmp/ghost.zip \
  && unzip -q /tmp/ghost.zip -d /ghost \
  && cd /ghost \
	&& npm install --production \
	&& npm install --save ghost-s3-storage \
	&& chown -R ghost.ghost * \
	&& apk del build-dependencies \
	&& npm cache clean \
	&& rm -rf /tmp/* /root/.node-gyp /var/cache/apk/*
	
RUN cd /ghost && rm -rf config.example.js content/

WORKDIR /ghost
VOLUME ./config.js
VOLUME ./content

CMD ["npm", "start", "--production"]
