# Stage 1
FROM node:14 as react-build
WORKDIR /app
COPY . ./
RUN npm --max-old-space-size=3072 install && npm --max-old-space-size=3072 run build

# Stage 2 - the production environment
FROM nginx:alpine
#COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=react-build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
