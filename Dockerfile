FROM archlinux/base as builder

WORKDIR /data
ADD ./dump.py /dump.py
RUN pacman -S --needed --noconfirm python pyalpm rsync nodejs npm git gcc g++ cmake make
RUN python /dump.py nodejs npm gcc g++ cmake git make > list
RUN rsync -avih ----exclude '*/' --files-from=/list / /data

FROM scratch

COPY --from=builder /data /