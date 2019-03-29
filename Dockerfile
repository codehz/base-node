FROM archlinux/base as builder

WORKDIR /data
LABEL maintainer=codehz
ARG TARGETS="nodejs npm base-devel cmake git make util-linux systemd-libs jq"
ADD ./dump.py /dump.py

RUN pacman -Syu --needed --noconfirm python pyalpm rsync ${TARGETS}
RUN python /dump.py ${TARGETS} > /list
RUN rsync -avih --exclude '*/' --files-from=/list / /data
ADD ./packager.sh /data

FROM scratch

COPY --from=builder /data /
