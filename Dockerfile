FROM gcr.io/tink-containers/debian:buster as builder
RUN apt-get update && apt-get install -y cmake g++
COPY . /project
WORKDIR /project
RUN rm -rf build && mkdir build
WORKDIR /project/build
RUN cmake .. && make -j$(nproc)
FROM gcr.io/distroless/base
COPY --from=builder /project/xgboost /
