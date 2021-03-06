# comskip-tvtplay
ð¬ Tiny tool to create TvtPlay-compatible CM chapter files automatically

[xtne6f/TvtPlay](https://github.com/xtne6f/TvtPlay) å¯¾å¿ã® CM ã¹ã­ãããã£ãã¿ã¼ãä½ãã¹ã¯ãªããã§ãã

SMB ãªã©ã§ãã©ã«ããåç§ã TVTest ã§åçãããã¨ã§èªå CM ã¹ã­ãããªç°å¢ãæ§ç¯ã§ãã¾ãã

`MOUNT_POINT` ã«æå®ããããã£ã¬ã¯ããªä»¥ä¸ã«ãã `*.m2ts` ã®ãã¹ã¦ã« Comskip ãé©ç¨ã, TvtPlay äºæã® `.chapter` ãã¡ã¤ã«ãçæãã¾ãã  
ãã£ãã¿ã¼ãã¡ã¤ã«ã¯ `<TS ãã¡ã¤ã«>/chapters` ãã£ã¬ã¯ããªä»¥ä¸ã«ä½æãããããã«ãªã£ã¦ãã¾ãã  
Comskip ã®ä¸¦åæ°ãã³ãã³ãã©ã¤ã³ã¯ `COMSKIP_PROCESSES` ããã³ `COMSKIP_COMMAND` ã§å¶å¾¡ã§ãã¾ãã

comskip.ini ã«ã¯æä½é `output_vdr=1` ãå¿è¦ã§ããcomskip-tvtplay ã¯çæããã .vdr ãã¡ã¤ã«ãä½¿ç¨ãã¾ãã

[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/slashnephy/comskip-tvtplay/latest)](https://hub.docker.com/r/slashnephy/comskip-tvtplay)

`docker-compose.yml`

```yaml
version: '3.8'

services:
  comskip-tvtplay:
    container_name: comskip-tvtplay
    image: slashnephy/comskip-tvtplay:latest
    restart: always
    volumes:
      - /mnt:/mnt
      - ./comskip.ini:/comskip.ini:ro
    environment:
      MOUNT_POINT: /mnt
      COMSKIP_PROCESSES: 4
      # Comskip ãèµ·åããã³ãã³ãã©ã¤ã³ãå¤æ´ãããå ´å
      COMSKIP_COMMAND: comskip --ini=/comskip.ini --ts
      # Comskip ããããããªããã¡ã¤ã«åã®ãã¿ã¼ã³ (è¤æ°æå®å¯è½)
      COMSKIP_IGNORE_NAME1: NHKç·å
      COMSKIP_IGNORE_NAME2: NHKæè²
      # Comskip ãããããã¡ã¤ã«ãæ¤ç´¢ããéé (ç§)
      COMSKIP_INTERVAL_SEC: 10
      # ä¸è¦ã«ãªã£ã .chapter ãã¡ã¤ã«ãåé¤ãã
      COMSKIP_CLEANUP: 1
```
