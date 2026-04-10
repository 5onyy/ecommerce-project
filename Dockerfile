FROM node:18-alpine
WORKDIR /app
RUN npm install -g npm@9
COPY package*.json .
COPY packages ./packages
COPY seed ./seed
RUN mkdir -p themes extensions public media
COPY config ./config
COPY translations ./translations
RUN npm install
RUN npm run build

EXPOSE 3000
CMD ["npm", "run", "start"]
