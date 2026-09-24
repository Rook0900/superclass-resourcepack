#!/bin/sh
# 클라이언트 모드를 빌드해서 GitHub 릴리즈에 올린다.
#   코드(G키 목록, AK 애니메이션, 히트마커 등)를 고쳤을 때만 필요하다.
#   모델만 고쳤다면 build_pack.sh 로 충분하다.
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
CLIENT="/c/Users/User/Desktop/SuperClassClient"
REPO="Rook0900/superclass-resourcepack"

(cd "$CLIENT" && ./gradlew build -q)
SRC=$(ls -t "$CLIENT"/build/libs/*.jar | grep -v sources | head -1)
cp "$SRC" "$HERE/superclassclient.jar"

gh release upload mod "$HERE/superclassclient.jar" --repo "$REPO" --clobber
echo "uploaded: $(du -h "$HERE/superclassclient.jar" | cut -f1)"
echo
echo "받는 곳 : https://github.com/$REPO/releases/tag/mod"
echo "주의    : 같은 파일명을 덮어썼으므로, 친구들이 예전 파일을 받을 수 있다."
echo "          몇 분 뒤에 받거나, 브라우저에서 새로고침하고 받으라고 하면 된다."
