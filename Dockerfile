FROM node:20-slim

RUN apt-get update && apt-get install -y \
  ffmpeg \
  imagemagick \
  webp \
  git \
  && apt-get upgrade -y \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /root

ARG GITHUB_TOKEN
RUN git clone https://${GITHUB_TOKEN}:x-oauth-basic@github.com/kurameshinatsuki/Supremus-IA bot-reel

WORKDIR /root/bot-reel

RUN npm install --production --legacy-peer-deps

EXPOSE 8000

CMD ["npm", "start"]
