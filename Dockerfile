FROM codehz/archlinux:latest as builder

WORKDIR /data
LABEL maintainer=codehz
ARG TARGETS="nodejs npm cmake make jq binutils base-devel git util-linux systemd-libs"

RUN pacman -Syu --needed --noconfirm python pyalpm rsync ${TARGETS}
RUN python /dump.py ${TARGETS} > /list
RUN rsync -avih --exclude '*/' --files-from=/list / /data && cp /packager.sh /data

FROM scratch

COPY --from=builder /data /
