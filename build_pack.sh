#!/bin/sh
# SuperClass 리소스팩 빌드
#   클라 모드의 assets/superclass 를 그대로 리소스팩으로 묶는다.
#   모델을 고친 뒤 이 스크립트만 돌리면 zip 과 sha1 이 갱신된다.
#
#   zip 대신 JDK 의 jar 를 쓴다. PowerShell 의 Compress-Archive 는
#   항목 경로를 역슬래시로 적어서 마인크래프트가 리소스팩을 못 읽는다.
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
SRC="/c/Users/User/Desktop/SuperClassClient/src/main/resources/assets/superclass"
OUT="$HERE/SuperClass_RP.zip"
JAR="/c/Program Files/Eclipse Adoptium/jdk-21.0.11.10-hotspot/bin/jar"
[ -x "$JAR" ] || JAR="/c/Program Files/Eclipse Adoptium/jdk-25.0.3.9-hotspot/bin/jar"

rm -rf "$HERE/build" "$OUT"
mkdir -p "$HERE/build/assets"
cp "$HERE/pack.mcmeta" "$HERE/build/"
cp -r "$SRC" "$HERE/build/assets/superclass"

# -M : 매니페스트를 넣지 않는다 (리소스팩엔 필요 없다)
(cd "$HERE/build" && "$JAR" --create --file "$OUT" --no-manifest pack.mcmeta assets)
rm -rf "$HERE/build"

SHA1=$(sha1sum "$OUT" | cut -d' ' -f1)
SIZE=$(du -h "$OUT" | cut -f1)
echo "$SHA1" > "$HERE/SuperClass_RP.sha1"
echo "built: $OUT  ($SIZE)"
echo "sha1 : $SHA1"
