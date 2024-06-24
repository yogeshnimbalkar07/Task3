FROM ubuntu:22.04
RUN apt update && apt install curl postgresql-client lsb-release gnupg2 -y
WORKDIR /app
RUN curl -fsSL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh &&  sh -E nodesource_setup.sh &&  apt update &&  apt install nodejs -y && npm install -g yarn && npm install pg --save

ENV STRAPI_DISABLE_3D_LOGO=true
RUN echo -e "skip\n" | npx create-strapi-app@latest strapi-server --quickstart --no-run
WORKDIR /app/strapi-server
RUN  yarn install
ENV DATABASE_CLIENT=postgres
ENV DATABASE_HOST=postgres
ENV DATABASE_PORT=5432
ENV DATABASE_NAME=strapi-db
ENV DATABASE_USERNAME=strapi
ENV DATABASE_PASSWORD=strapi-user
RUN yarn build
EXPOSE 1337
CMD ["yarn", "start"]

