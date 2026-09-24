#!/bin/sh
# SuperClass 서버 리소스팩 빌드
#
#   base/        — GUI·텍스처 등 손으로 관리하는 것 (예전 ClassSelectRP 내용)
#   클라 모드    — assets/superclass 의 모델. 여기서 그대로 가져온다.
#
#   모델을 고친 뒤 이 스크립트만 돌리면 zip 과 sha1 이 갱신된다.
#
#   zip 대신 JDK 의 jar 를 쓴다. PowerShell 의 Compress-Archive 도,
#   예전 빌드도 항목 경로를 역슬래시로 적어서 마인크래프트가 못 읽었다.
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
SRC="/c/Users/User/Desktop/SuperClassClient/src/main/resources/assets/superclass"
OUT="$HERE/SuperClass_RP.zip"
JAR="/c/Program Files/Eclipse Adoptium/jdk-21.0.11.10-hotspot/bin/jar"
[ -x "$JAR" ] || JAR="/c/Program Files/Eclipse Adoptium/jdk-25.0.3.9-hotspot/bin/jar"

rm -rf "$HERE/build" "$OUT"
mkdir -p "$HERE/build"
cp "$HERE/pack.mcmeta" "$HERE/build/"
cp -r "$HERE/base/assets" "$HERE/build/assets"
# 모델은 클라 모드 쪽이 원본이다. 겹치면 이쪽이 이긴다.
cp -r "$SRC/." "$HERE/build/assets/superclass/"

(cd "$HERE/build" && "$JAR" --create --file "$OUT" --no-manifest pack.mcmeta assets)
rm -rf "$HERE/build"

SHA1=$(sha1sum "$OUT" | cut -d' ' -f1)
echo "$SHA1" > "$HERE/SuperClass_RP.sha1"
echo "built: $OUT  ($(du -h "$OUT" | cut -f1))"
echo "sha1 : $SHA1"
echo
echo "다음 단계:"
echo "  gh release upload rp \"$OUT\" --repo Rook0900/superclass-resourcepack --clobber"
echo "  server.properties 의 resource-pack-sha1 을 위 값으로 바꾸고 서버 재시작"
