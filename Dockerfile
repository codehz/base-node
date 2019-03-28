FROM archlinux/base as builder

WORKDIR /data
ADD ./dump.py /dump.py
RUN pacman -S --needed --noconfirm python rsync nodejs gcc g++ cmake
RUN python /dump.py nodejs gcc g++ cmake > list
RUN rsync -avih ----exclude '*/' --files-from=/list / /data

FROM scratch

COPY --from=builder /data /