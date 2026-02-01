FROM nginx:alpine

# Replace default config
RUN rm /etc/nginx/conf.d/default.conf

# Copy the template file
COPY default.conf.template /etc/nginx/templates/default.conf.template

# Copy the static files
COPY /dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
