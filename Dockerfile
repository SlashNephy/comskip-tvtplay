FROM slashnephy/comskip:latest AS comskip

RUN apk add --update --no-cache python3

RUN addgroup -S comskip \
    && adduser -S comskip -G comskip
USER comskip

ENV MOUNT_POINT=/mnt
ENV COMSKIP_PROCESSES=1
ENV COMSKIP_COMMAND="comskip --ini=/comskip.ini --ts"

COPY entrypoint.py /entrypoint.py
ENTRYPOINT [ "python3", "-u", "entrypoint.py" ]
