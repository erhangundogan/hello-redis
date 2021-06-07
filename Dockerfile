FROM node:alpine
RUN apk add dumb-init
ENV NODE_ENV production
WORKDIR /app
COPY --chown=node:node . .
COPY --chown=node:node src src
RUN npm ci --only=production
USER node
CMD ["dumb-init", "node", "src/index.js"]
