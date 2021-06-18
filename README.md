# comskip-tvtplay
🎬 Tiny tool to create TvtPlay-compatible CM chapter files automatically

[xtne6f/TvtPlay](https://github.com/xtne6f/TvtPlay) 対応の CM スキップチャプターを作るスクリプトです。

SMB などでフォルダを参照し TVTest で再生することで自動 CM スキップな環境を構築できます。

`MOUNT_POINT` に指定されたディレクトリ以下にある `*.m2ts` のすべてに Comskip を適用し, TvtPlay 互換の `.chapter` ファイルを生成します。  
チャプターファイルは `<TS ファイル>/chapters` ディレクトリ以下に作成されるようになっています。  
Comskip の並列数やコマンドラインは `COMSKIP_PROCESSES` および `COMSKIP_COMMAND` で制御できます。

comskip.ini には最低限 `output_vdr=1` が必要です。comskip-tvtplay は生成される .vdr ファイルを使用します。

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
      # Comskip を起動するコマンドラインを変更したい場合
      COMSKIP_COMMAND: comskip --ini=/comskip.ini --ts
      # Comskip をかけたくないファイル名のパターン (複数指定可能)
      COMSKIP_IGNORE_NAME1: NHK総合
      COMSKIP_IGNORE_NAME2: NHK教育
      # Comskip をかけるファイルを検索する間隔 (秒)
      COMSKIP_INTERVAL_SEC: 10
      # 不要になった .chapter ファイルを削除する
      COMSKIP_CLEANUP: 1
```
