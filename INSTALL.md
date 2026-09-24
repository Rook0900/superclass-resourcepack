# 설치 방법

## 1. Fabric 설치

https://fabricmc.net/use/installer 에서 설치 프로그램을 받아 **실행**합니다.

- **Minecraft Version**: `26.2`
- 나머지는 기본값 그대로 두고 **Install**

설치가 끝나면 프로그램은 지워도 됩니다.

## 2. 한 번 실행해서 폴더를 만들기

마인크래프트 실행기에서 **`fabric-loader-26.2`** 프로필을 선택하고 실행합니다.
게임이 켜지면 바로 꺼도 됩니다. 이 과정에서 `mods` 폴더가 자동으로 생깁니다.

> 폴더를 직접 만들지 마세요. 이름을 `mod` 로 만들면 아무것도 인식되지 않습니다.

## 3. 모드 넣기

**SuperClass_mods.zip** 을 받습니다.
https://github.com/Rook0900/superclass-resourcepack/releases/tag/mod

`Win + R` → `%APPDATA%\.minecraft` → 확인 으로 폴더를 열고,
**zip 안의 `mods` 폴더를 여기에 풀어넣습니다.** (덮어쓰기 하면 됩니다)

안에 이미 다 들어 있습니다.

| 파일 | 역할 |
|---|---|
| `fabric-api-*.jar` | Fabric 기본 라이브러리 (없으면 게임이 튕깁니다) |
| `superclassclient.jar` | SuperClass 클라이언트 모드 |

## 4. 실행

실행기에서 **`fabric-loader-26.2`** 프로필로 실행합니다.
바닐라 프로필로 켜면 모드가 하나도 안 켜집니다.

---

## 제대로 됐는지 확인

- 타이틀 화면의 **Mods** 목록에 `Fabric API` 와 `SuperClass Client` 가 보임
- 서버 접속 시 채팅에 `[SuperClass] Fabric 클라이언트 모드 등록됨.` 이 뜸
- 접속할 때 리소스팩을 받겠냐고 물으면 **수락**

## 런처가 다른 경우

`mods` 폴더 위치는 런처마다 다릅니다. 어느 런처든 **"폴더 열기"** 버튼이 있습니다.

| 런처 | 찾는 법 |
|---|---|
| 공식 런처 | 설치(Installations) → 프로필 옆 `···` → 폴더 열기 |
| Prism / MultiMC | 인스턴스 선택 → Folder |
| CurseForge | 프로필 → Open Folder |

## 안 받아도 되는 것

- **리소스팩** — 서버에 접속하면 자동으로 받아집니다
- **Sodium / Iris** — 최적화·셰이더 모드. 이 게임에 필요 없습니다

## 모드를 안 깔면

게임은 됩니다. 능력·모델·이펙트는 전부 서버가 처리합니다.
못 쓰는 것은 **G키 직업 목록**, **AK 재장전 애니메이션**, **히트마커 등 클라 전용 연출** 입니다.

## 흔한 실수

- 폴더를 `mod` 로 만듦 → 반드시 `mods`
- 바닐라 프로필로 실행 → `fabric-loader-26.2` 를 골라야 함
- Fabric API 를 빼먹음 → 시작하자마자 튕김
- GitHub 첫 화면의 `<> Code → Download ZIP` 을 받음 → 그건 소스코드입니다. **Releases → Assets** 에서 받으세요
