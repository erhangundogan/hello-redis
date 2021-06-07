FROM node:alpine
RUN apk add dumb-init curl
ENV NODE_ENV production
WORKDIR /usr/src/app
COPY --chown=node:node . .
RUN npm ci --only=production
USER node
CMD ["dumb-init", "node", "index.js"]
