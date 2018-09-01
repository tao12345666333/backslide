FROM node:8.11.4

MAINTAINER Jintao Zhang <zhangjintao9020@gmail.com>

# https://docs.npmjs.com/misc/config#unsafe-perm
# https://github.com/nodejs/node-gyp/issues/454
RUN npm install --unsafe-perm -g backslide

WORKDIR /src

ENTRYPOINT [ "bs" ]
CMD [ "--help" ]
