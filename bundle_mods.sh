#!/bin/sh
# 친구들에게 줄 "mods 폴더 통째" 묶음을 만든다.
#   압축을 .minecraft 에 풀면 mods 폴더가 알맞은 이름으로 생기고
#   Fabric API 와 클라 모드가 그 안에 들어간다.
#   (폴더 이름을 mod 로 잘못 만들거나 API 를 빠뜨리는 실수를 없애려는 것)
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
CLIENT="/c/Users/User/Desktop/SuperClassClient"
MCMODS="/c/Users/User/AppData/Roaming/.minecraft/mods"
REPO="Rook0900/superclass-resourcepack"
JAR="/c/Program Files/Eclipse Adoptium/jdk-21.0.11.10-hotspot/bin/jar"
[ -x "$JAR" ] || JAR="/c/Program Files/Eclipse Adoptium/jdk-25.0.3.9-hotspot/bin/jar"

API=$(ls "$MCMODS"/fabric-api-*.jar 2>/dev/null | head -1)
[ -n "$API" ] || { echo "Fabric API 를 못 찾았습니다: $MCMODS"; exit 1; }

(cd "$CLIENT" && ./gradlew build -q)
SRC=$(ls -t "$CLIENT"/build/libs/*.jar | grep -v sources | head -1)

rm -rf "$HERE/bundle"
mkdir -p "$HERE/bundle/mods"
cp "$API" "$HERE/bundle/mods/"
cp "$SRC" "$HERE/bundle/mods/superclassclient.jar"
# zip 항목 이름에 한글을 쓰면 압축 프로그램에 따라 깨진다. ASCII 로 둔다.
cp "$HERE/INSTALL.md" "$HERE/bundle/INSTALL.txt" 2>/dev/null || true

OUT="$HERE/SuperClass_mods.zip"
rm -f "$OUT"
(cd "$HERE/bundle" && "$JAR" --create --file "$OUT" --no-manifest mods INSTALL.txt)
rm -rf "$HERE/bundle"

echo "built: $OUT ($(du -h "$OUT" | cut -f1))"
echo "  포함: $(basename "$API")"
echo "        superclassclient.jar"

[ "$1" = "--local" ] && exit 0
gh release upload mod "$OUT" --repo "$REPO" --clobber
echo "uploaded"
