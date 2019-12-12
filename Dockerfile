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
<<<<<<< HEAD
# FROM nginx:alpine
FROM nginx:1.17.3
RUN rm -rf /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/dist/expo /usr/share/nginx/html
# RUN chown nginx:nginx /usr/share/nginx/html
EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]
=======
#FROM nginx:alpine
FROM nginx:1.17.3
RUN rm -rf /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/dist/Expo /usr/share/nginx/html
#RUN chown nginx:nginx /usr/share/nginx/html
EXPOSE 80
#CMD ["nginx", "-g", "daemon off;"]
>>>>>>> b26a8530b58e3a2d0ec4bc61c74e071b7cab429d
