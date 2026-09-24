# SuperClass 리소스팩

SuperClass 미니게임의 커스텀 모델(직업 능력 이펙트)을 담은 서버 리소스팩입니다.

서버에 접속하면 자동으로 받아지므로 **따로 설치할 필요가 없습니다.**

## 갱신하는 법

모델을 고친 뒤:

```sh
./build_pack.sh
gh release upload rp SuperClass_RP.zip --clobber
```

그리고 `server.properties` 의 `resource-pack-sha1` 을 새로 나온 값으로 바꾸고 서버를 재시작합니다.

## 다운로드 주소

```
https://github.com/Rook0900/superclass-resourcepack/releases/latest/download/SuperClass_RP.zip
```

이 주소는 고정입니다. 릴리즈를 갈아끼워도 바뀌지 않습니다.
