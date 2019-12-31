docker-tv-recorder
===

[![Test on master](https://github.com/ww24/docker-tv-recorder/workflows/Test%20on%20master/badge.svg)](https://github.com/ww24/docker-tv-recorder/actions?query=workflow%3A%22Test+on+master%22)

## Requirements
- docker
- direnv
- pcscd (Mirakurun)

## Usage

### chinachu

- `.envrc` の `DOCKER_HOST` の値には `tcp://${DOCKER_HOST_IP}:2375` を指定します。
  - `docker-compose` を実行するマシンと同一であれば不要です。
- `.env` の `MIRAKURUN_PATH` の値には Mirakurun の API のエンドポイントを指定します。

```
docker-compose build
docker-compose up -d
```

### mirakurun

- `.envrc` の `DOCKER_HOST` の値には `tcp://${DOCKER_HOST_IP}:2375` を指定します。
  - `docker-compose` を実行するマシンと同一であれば不要です。
- host に B-CAS カードが挿入されたカードリーダーが接続されていて、 pcscd によって認識されている必要があります。

```
docker-compose build
docker-compose up -d
```

## References

- https://github.com/Chinachu/Mirakurun/blob/master/doc/Configuration.md
- https://github.com/Chinachu/Chinachu/wiki/Gamma-Configuration
- https://github.com/Chinachu/docker-mirakurun-chinachu

## Disclaimer

- 仕様理解を目的とした私的利用を想定しているため、ビルド済みのバイナリ、イメージの配布は行いません。
- 各プログラムのソースは、ビルド時に配布元から直接ダウンロードするため、配布元が配布を終了した際には、ビルドできません。
- 配布物を利用したことに依る権利上のトラブル、プログラムやハードウェアへの損害など、生じたあらゆるトラブルや損害について、配布者は責任を負いません。
- 日本国内で、日本国の法律を遵守してご利用ください。

## License

Dockerfile や shell script 等、直接的な配布物に関しては [Unlicense](https://unlicense.org/) とし、配布者はいかなる権利も主張しません。

他の配布元からダウンロードされるソフトウェア等に関しては、各配布元の License に従ってください。
