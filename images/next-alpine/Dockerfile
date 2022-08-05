# BASE
ARG NEXT_VERSION=12.2.0
ARG NODE_VERSION=16
FROM node:${NODE_VERSION}-alpine AS base-alpine
EXPOSE 3000

FROM base-alpine

RUN yarn global add next@${NEXT_VERSION}


RUN mkdir -p /srv/app && chown 1000:1000 -R /srv/app

WORKDIR /srv/app

VOLUME /srv/app

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod 777 /usr/local/bin/docker-entrypoint.sh && ln -s /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["next"]
