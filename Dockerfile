# The builder from node image
FROM node:alpine as builder

# build-time variables 
# prod|sandbox its value will be come from outside 
ARG env=prod

RUN apk update && apk add --no-cache make git

# Move our files into directory name "app"
WORKDIR /app
COPY package.json package-lock.json  /app/
RUN npm install @angular/cli@6.0.8 -g
RUN cd /app && npm install
COPY .  /app

# Build with $env variable from outside
#RUN cd /app && npm run build:$env
RUN cd /app && npm run build

# Build a small nginx image with static website
# FROM nginx:alpine
FROM nginx:1.17.3
RUN rm -rf /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/dist/expo /usr/share/nginx/html
# RUN chown nginx:nginx /usr/share/nginx/html
EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]