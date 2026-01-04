# syntax=docker/dockerfile:1@sha256:b6afd42430b15f2d2a4c5a02b919e98a525b785b1aaff16747d2f623364e39b6

FROM ghcr.io/slashnephy/comskip:master@sha256:a099c7f85ea0dc25d87b846b6cd71db5512b2ada5fc280da3fc9839e087d48fb

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
