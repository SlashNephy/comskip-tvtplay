# syntax=docker/dockerfile:1

FROM ghcr.io/slashnephy/comskip:master@sha256:190f438ef56d685e9f0a7cd959d32d1f27c05f3012a7567cedfb3edb4dc9e86a

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
