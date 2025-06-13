FROM gcc:9.3.0 AS build
WORKDIR /app
COPY . /app/
RUN apt-get update && apt-get install -y cmake && mkdir build && cd build && cmake ../ && make

FROM debian:bullseye-slim
WORKDIR /app
COPY --from=build /app/build/PoGo/PoGo /usr/local/bin/PoGo
COPY --from=build /app/input/ /app/input/
EXPOSE 8080
CMD ["PoGo"]
