# comskip-tvtplay
🎬 Tiny tool to create TvtPlay-compatible CM chapter files automatically

[xtne6f/TvtPlay](https://github.com/xtne6f/TvtPlay) 対応の CM スキップチャプターを作るスクリプトです。

SMB などでフォルダを参照し TVTest で再生することで自動 CM スキップな環境を構築できます。

`MOUNT_POINT` に指定されたディレクトリ以下にある `*.m2ts` のすべてに Comskip を適用し, TvtPlay 互換の `.chapter` ファイルを生成します。  
チャプターファイルは `<TS ファイル>/chapters` ディレクトリ以下に作成されるようになっています。  
Comskip の並列数やコマンドラインは `COMSKIP_PROCESSES` および `COMSKIP_COMMAND` で制御できます。

[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/slashnephy/comskip-tvtplay/latest)](https://hub.docker.com/r/slashnephy/comskip-tvtplay)

`docker-compose.yml`

```yaml
version: '3.8'

services:
  comskip-tvtplay:
    container_name: comskip-tvtplay
    image: slashnephy/comskip-all-tvtplay:latest
    restart: always
    volumes:
      - /mnt:/mnt
      - ./comskip.ini:/comskip.ini:ro
    environment:
      MOUNT_POINT: /mnt
      COMSKIP_PROCESSES: 4
      COMSKIP_COMMAND: comskip --ini=/comskip.ini --ts
```
