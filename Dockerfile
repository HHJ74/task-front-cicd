# Build stage (build 스테이지를 명시적으로 정의)
FROM node:14-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage (nginx로 배포)
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build .   
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
