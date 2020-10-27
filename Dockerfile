FROM node:alpine AS builder
WORKDIR /app
COPY package.json .
RUN npm config set registry http://registry.npmjs.org/
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# port for incoming traffic on AWS elastic beanstalk
EXPOSE 80
# only copy contents of build directory
COPY --from=builder /app/build /usr/share/nginx/html
