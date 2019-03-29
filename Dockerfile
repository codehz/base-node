FROM archlinux/base as builder

WORKDIR /data
ADD ./dump.py /dump.py
RUN pacman -Sy --needed --noconfirm python pyalpm rsync nodejs npm git gcc cmake make
RUN python /dump.py nodejs npm gcc cmake git make libtool util-linux > /list
RUN rsync -avih --exclude '*/' --files-from=/list / /data

FROM scratch

COPY --from=builder /data /
