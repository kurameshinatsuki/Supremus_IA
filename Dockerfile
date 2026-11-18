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

# Évite le téléchargement CUDA d'onnxruntime-node
ENV ONNXRUNTIME_NODE_INSTALL_CUDA=skip

RUN npm install --omit=dev --legacy-peer-deps

EXPOSE 8000

CMD ["npm", "start"]