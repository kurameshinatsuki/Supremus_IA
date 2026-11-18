FROM node:20-slim

RUN apt-get update && apt-get install -y \
  ffmpeg \
  imagemagick \
  webp \
  git \
  python3 \
  make \
  g++ \
  && apt-get upgrade -y \
  && rm -rf /var/lib/apt/lists/*

# Client Docker : l'outil executer_code lance son bac à sable via le socket Docker du runner
COPY --from=docker:cli /usr/local/bin/docker /usr/local/bin/docker

WORKDIR /root

ARG GITHUB_TOKEN
RUN git clone https://${GITHUB_TOKEN}:x-oauth-basic@github.com/kurameshinatsuki/Supremus-IA bot-reel

WORKDIR /root/bot-reel

RUN npm install --production --legacy-peer-deps || (cat /root/.npm/_logs/*.log && exit 1)

EXPOSE 8000

CMD ["npm", "start"]