FROM ghcr.io/slashnephy/comskip:sha-26d5d2b@sha256:a9ed30b8c23bb0304b47b06c3394b318ff7bc9337bb3c6e1f88166dfc64b650a AS comskip

RUN apt-get update \
    && apt-get full-upgrade -y \
    && apt-get install -y --no-install-recommends \
        python3 \
    && rm -rf /var/lib/apt/lists/*

ENV MOUNT_POINT=/mnt
ENV COMSKIP_PROCESSES=1
ENV COMSKIP_COMMAND="comskip --ini=/comskip.ini --ts"
ENV COMSKIP_INTERVAL_SEC=10
ENV COMSKIP_CLEANUP=0

COPY entrypoint.py /entrypoint.py
ENTRYPOINT [ "python3", "-u", "/entrypoint.py" ]
