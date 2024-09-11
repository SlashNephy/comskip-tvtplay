# syntax=docker/dockerfile:1@sha256:865e5dd094beca432e8c0a1d5e1c465db5f998dca4e439981029b3b81fb39ed5

FROM ghcr.io/slashnephy/comskip:master@sha256:01626a1dd4d762f537d5eb493d02b0a02e0d89b962dbb6fb0af85aad899cb5e3

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
