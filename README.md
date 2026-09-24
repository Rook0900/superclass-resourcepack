# SuperClass 리소스팩

SuperClass 미니게임의 커스텀 모델과 GUI 텍스처를 담은 **서버 리소스팩**입니다.
서버에 접속하면 자동으로 받아지므로 **따로 설치할 필요가 없습니다.**

## 갱신하는 법

모델을 고친 뒤 이것만 실행하면 됩니다.

```sh
./build_pack.sh
```

이 스크립트가 알아서 하는 일:

1. `base/` 의 GUI·텍스처 + 클라 모드의 `assets/superclass` 모델을 하나로 묶는다
2. 파일명에 해시를 박아 zip 을 만든다
3. GitHub 릴리즈에 올린다
4. `server.properties` 의 `resource-pack` 과 `resource-pack-sha1` 을 갱신한다

그 다음 **서버만 재시작**하면 접속하는 사람 전원에게 반영됩니다.

올리지 않고 빌드만 보려면 `./build_pack.sh --local`.

## 폴더 구성

| | 원본이 어디인가 |
|---|---|
| `base/assets` | 여기 (GUI, 블록 텍스처, 리볼버·자물쇠 모델) |
| `assets/superclass` 의 능력 모델 | **클라 모드** `SuperClassClient/src/main/resources` |

능력 모델은 클라 모드 쪽을 고치면 됩니다. 여기에 복사본을 두지 않습니다.

## 알아둘 것

- **zip 은 반드시 `jar` 로 묶습니다.** PowerShell 의 `Compress-Archive` 는 항목 경로를
  역슬래시로 적어서 자바가 파일을 못 찾습니다. 예전 팩이 이 문제로 동작하지 않았습니다.
- **파일명에 해시를 넣습니다.** 같은 이름으로 덮어쓰면 GitHub CDN 이 한참 동안
  옛 파일을 내려줘서 sha1 이 어긋나고 리소스팩이 통째로 실패합니다.
