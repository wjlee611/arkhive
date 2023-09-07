# Arkhive

명일방주 오프라인 아카이브 Flutter 애플리케이션 입니다.

Flutter 코드가 궁금하신 분들을 위해 코드를 공개합니다.\
단, 이 프로젝트는 `GPL-3 라이센스`를 따릅니다.\
따라서, 해당 코드를 이용해서 상업적으로 이용하실 때 `반드시 소스코드를 공개 및 GPL-3 라이센스를 명시`해야만 합니다.

또한, 정상적인 구동을 위해서는 아래의 데이터를 수동으로 프로젝트에 포함시켜야 합니다.

```.gitignore
# AK GameData
/assets/data/ko_KR/
/assets/data/zh_CN/

# Penguin matrix
/assets/data/penguin_matrix_cn.json
/assets/data/penguin_matrix_us.json

# Images
/assets/images/enemy/<enemyId>.png                    # 적 id로 명명된 적 아이콘
/assets/images/item/<iconId>.png                      # 아이템 아이콘 id로 명명된 아이템 아이콘 (배경 포함)
/assets/images/operator/<characterPrefabKey>.png      # 오퍼레이터 인덱스 id로 명명된 오퍼레이터 아이콘
/assets/images/tutorials/arkhive_tutorial_[1-5].png   # 자체 제작한 소개사진 5장
/assets/images/class_[8_profession].png               # 포지션 아이콘
/assets/images/e[0-2].png                             # 정예화 아이콘
/assets/images/item[0-6].png                          # 아이템 배경 아이콘 (deprecated)
/assets/images/p[1-6].png                             # 잠재능력 아이콘
/assets/images/prts.png                               # prts 아이콘

# 아래 파일은 배포에 필요한 파일입니다.
# 실험 및 개발용으로는 포함시키지 않아도 무방합니다.
# Deploy - android
android/app/upload-keystore.jks
android/key.properties

# Deploy - fastlane
android/pc-api-<key_id>.json
```

상기 `AK GameData`는 아래의 레포를 참고해주세요.\
[인게임 데이터 - ArknightsGameData](https://github.com/Kengxxiao/ArknightsGameData)\
[인게임 이미지 - ArknightsGameResource](https://github.com/yuanyan3060/ArknightsGameResource)

`Penguin matrix`는 [penguin-stats.io](https://penguin-stats.io/) 의 `api - v2` 를 사용해주세요.

</br>

## Getting Started

프로젝트 초기화를 위해 우선 아래의 명령어로 관련 라이브러리를 설치해주세요.

```bash
$ flutter pub get
```

</br>

### Debug

`main.dart` 파일에서 `main()` 함수를 `Debug` 모드로 실행합니다.\
device는 `Android`, `iOS`만 가능합니다.

</br>

### Build

- .abb

```bash
$ flutter build appbundle
```

- .apk

```bash
$ flutter build apk --release --target-platform=android-arm64
```

</br>

### Auto deploy

**Fastlane 서비스를 사용합니다.**\
**따라서, `Google Cloud Service`, `Google Play Console`과 `Fastlane`의 연동이 필요합니다.**\
**연동 방법은 [여기 포스트](https://with611.tistory.com/158)를 참고해주세요.**

</br>

- Play 스토어 (내부 테스트)

```bash
  $ cd android/
  $ fastlane beta
```

- Play 스토어 (프로덕션) - _권장하지 않음_

```bash
  $ cd android/
  $ fastlane deploy
```

</br>

## Contribute

프로젝트에 직접 기여해 주시려면 fork하신 후 업데이트 사항을 [PR](https://github.com/wjlee611/arkhive/pulls)로 올려주세요!

간접적으로 기여해 주시려면 [여기](https://with611.tistory.com/159)에 의견을 남겨주세요.\
또는, [이슈](https://github.com/wjlee611/arkhive/issues)에 문제를 남겨주세요!
