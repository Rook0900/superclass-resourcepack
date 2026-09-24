#!/bin/sh
# SuperClass 서버 리소스팩 빌드 & 배포
#
#   base/      — GUI·텍스처 등 손으로 관리하는 것 (예전 ClassSelectRP 내용)
#   클라 모드  — assets/superclass 의 모델. 원본은 항상 이쪽이다.
#
#   모델을 고친 뒤 이 스크립트만 돌리면
#     1) zip 을 다시 묶고  2) GitHub 릴리즈에 올리고  3) server.properties 를 갱신한다.
#   그 다음 서버만 재시작하면 접속하는 사람 전원에게 자동 반영된다.
#
#   파일명에 해시를 넣는 이유: 같은 이름으로 덮어쓰면 GitHub CDN 이
#   한참 동안 옛 파일을 내려줘서 sha1 이 어긋나고 리소스팩이 통째로 실패한다.
#
#   zip 대신 JDK 의 jar 를 쓰는 이유: PowerShell 의 Compress-Archive 도,
#   예전 빌드도 항목 경로를 역슬래시로 적어서 자바가 파일을 못 찾았다.
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
SRC="/c/Users/User/Desktop/SuperClassClient/src/main/resources/assets/superclass"
PROPS="/c/Users/User/Desktop/asdf/server.properties"
REPO="Rook0900/superclass-resourcepack"
TAG="rp"
JAR="/c/Program Files/Eclipse Adoptium/jdk-21.0.11.10-hotspot/bin/jar"
[ -x "$JAR" ] || JAR="/c/Program Files/Eclipse Adoptium/jdk-25.0.3.9-hotspot/bin/jar"

rm -rf "$HERE/build"
mkdir -p "$HERE/build"
cp "$HERE/pack.mcmeta" "$HERE/build/"
cp -r "$HERE/base/assets" "$HERE/build/assets"
cp -r "$SRC/." "$HERE/build/assets/superclass/"

TMP="$HERE/SuperClass_RP.zip"
rm -f "$TMP"
(cd "$HERE/build" && "$JAR" --create --file "$TMP" --no-manifest pack.mcmeta assets)
rm -rf "$HERE/build"

SHA1=$(sha1sum "$TMP" | cut -d' ' -f1)
NAME="SuperClass_RP-${SHA1%${SHA1#????????}}.zip"   # 해시 앞 8자리
OUT="$HERE/$NAME"
rm -f "$HERE"/SuperClass_RP-*.zip
mv "$TMP" "$OUT"
echo "$SHA1" > "$HERE/SuperClass_RP.sha1"
URL="https://github.com/$REPO/releases/download/$TAG/$NAME"

echo "built : $NAME  ($(du -h "$OUT" | cut -f1))"
echo "sha1  : $SHA1"

if [ "$1" = "--local" ]; then
    echo "(로컬 빌드만 했습니다. 올리려면 인자 없이 다시 실행하세요)"
    exit 0
fi

gh release upload "$TAG" "$OUT" --repo "$REPO" --clobber
echo "uploaded"

# server.properties 갱신 (properties 형식이라 콜론을 이스케이프해야 한다)
ESC=$(printf '%s' "$URL" | sed 's|:|\:|')
python - "$PROPS" "$ESC" "$SHA1" <<'PY'
import io, sys
path, url, sha1 = sys.argv[1], sys.argv[2], sys.argv[3]
lines = io.open(path, encoding="utf-8").read().split("\n")
for i, l in enumerate(lines):
    if l.startswith("resource-pack="):
        lines[i] = "resource-pack=" + url
    elif l.startswith("resource-pack-sha1="):
        lines[i] = "resource-pack-sha1=" + sha1
io.open(path, "w", encoding="utf-8").write("\n".join(lines))
print("server.properties 갱신됨")
PY
echo
echo "URL : $URL"
echo "이제 서버만 재시작하면 됩니다."
