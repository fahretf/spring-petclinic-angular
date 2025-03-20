FROM node:alpine AS buildstage

WORKDIR /app

COPY package*.json .
RUN npm install

COPY . . 
RUN npm run build 

FROM nginx:alpine
COPY --from=buildstage /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

EXPOSE 80
CMD ["/docker-entrypoint.sh"]