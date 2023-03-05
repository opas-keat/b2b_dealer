# Stage 1
FROM opas/flutter:3.7.6 AS build-env

RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter pub get
RUN flutter build web

# Stage 2
FROM nginx:1.23.3-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html