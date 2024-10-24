# syntax=docker/dockerfile:1

FROM ghcr.io/slashnephy/comskip:master@sha256:bc58118d7fdc88071eaf9ccc188a850922901edecd57f8f74b6fad0ac92da692

RUN <<EOF
    apt-get update
    apt-get install -y --no-install-recommends python3
    apt-get clean
    rm -rf /var/lib/apt/lists/*
EOF

ENV MOUNT_POINT=/mnt
ENV COMSKIP_PROCESSES=1
ENV COMSKIP_COMMAND="comskip --ini=/comskip.ini --ts"
ENV COMSKIP_CLEANUP=0

COPY entrypoint.py /entrypoint.py
ENTRYPOINT [ "python3", "-u", "/entrypoint.py" ]
