String subProSelector(String eng) {
  const Map<String, dynamic> list = {
    "notchar1": {
      "subProfessionId": "notchar1",
      "subProfessionName": "오퍼레이터 추가 유닛",
      "subProfessionCatagory": 1
    },
    "notchar2": {
      "subProfessionId": "notchar2",
      "subProfessionName": "무직업 함정",
      "subProfessionCatagory": 2
    },
    "none1": {
      "subProfessionId": "none1",
      "subProfessionName": "예비용1",
      "subProfessionCatagory": 3
    },
    "none2": {
      "subProfessionId": "none2",
      "subProfessionName": "예비용1",
      "subProfessionCatagory": 4
    },
    "pioneer": {
      "subProfessionId": "pioneer",
      "subProfessionName": "척후병",
      "subProfessionCatagory": 5
    },
    "charger": {
      "subProfessionId": "charger",
      "subProfessionName": "돌격수",
      "subProfessionCatagory": 6
    },
    "tactician": {
      "subProfessionId": "tactician",
      "subProfessionName": "전술가",
      "subProfessionCatagory": 7
    },
    "bearer": {
      "subProfessionId": "bearer",
      "subProfessionName": "기수",
      "subProfessionCatagory": 8
    },
    "centurion": {
      "subProfessionId": "centurion",
      "subProfessionName": "공격수",
      "subProfessionCatagory": 9
    },
    "fighter": {
      "subProfessionId": "fighter",
      "subProfessionName": "파이터",
      "subProfessionCatagory": 10
    },
    "artsfghter": {
      "subProfessionId": "artsfghter",
      "subProfessionName": "아츠 파이터",
      "subProfessionCatagory": 11
    },
    "instructor": {
      "subProfessionId": "instructor",
      "subProfessionName": "교관",
      "subProfessionCatagory": 12
    },
    "lord": {
      "subProfessionId": "lord",
      "subProfessionName": "로드",
      "subProfessionCatagory": 13
    },
    "sword": {
      "subProfessionId": "sword",
      "subProfessionName": "소드마스터",
      "subProfessionCatagory": 14
    },
    "musha": {
      "subProfessionId": "musha",
      "subProfessionName": "무사",
      "subProfessionCatagory": 15
    },
    "fearless": {
      "subProfessionId": "fearless",
      "subProfessionName": "드레드노트",
      "subProfessionCatagory": 16
    },
    "reaper": {
      "subProfessionId": "reaper",
      "subProfessionName": "리퍼",
      "subProfessionCatagory": 17
    },
    "librator": {
      "subProfessionId": "librator",
      "subProfessionName": "해방자",
      "subProfessionCatagory": 18
    },
    "protector": {
      "subProfessionId": "protector",
      "subProfessionName": "프로텍터",
      "subProfessionCatagory": 19
    },
    "guardian": {
      "subProfessionId": "guardian",
      "subProfessionName": "가디언",
      "subProfessionCatagory": 20
    },
    "unyield": {
      "subProfessionId": "unyield",
      "subProfessionName": "저거너트",
      "subProfessionCatagory": 21
    },
    "artsprotector": {
      "subProfessionId": "artsprotector",
      "subProfessionName": "아츠 프로텍터",
      "subProfessionCatagory": 22
    },
    "duelist": {
      "subProfessionId": "duelist",
      "subProfessionName": "결전자",
      "subProfessionCatagory": 23
    },
    "fortress": {
      "subProfessionId": "fortress",
      "subProfessionName": "포트리스",
      "subProfessionCatagory": 24
    },
    "fastshot": {
      "subProfessionId": "fastshot",
      "subProfessionName": "명사수",
      "subProfessionCatagory": 25
    },
    "closerange": {
      "subProfessionId": "closerange",
      "subProfessionName": "헤비슈터",
      "subProfessionCatagory": 26
    },
    "aoesniper": {
      "subProfessionId": "aoesniper",
      "subProfessionName": "포격사수",
      "subProfessionCatagory": 27
    },
    "longrange": {
      "subProfessionId": "longrange",
      "subProfessionName": "저격수",
      "subProfessionCatagory": 28
    },
    "reaperrange": {
      "subProfessionId": "reaperrange",
      "subProfessionName": "산탄사수",
      "subProfessionCatagory": 29
    },
    "siegesniper": {
      "subProfessionId": "siegesniper",
      "subProfessionName": "공성사수",
      "subProfessionCatagory": 30
    },
    "bombarder": {
      "subProfessionId": "bombarder",
      "subProfessionName": "투척수",
      "subProfessionCatagory": 31
    },
    "corecaster": {
      "subProfessionId": "corecaster",
      "subProfessionName": "코어 캐스터",
      "subProfessionCatagory": 32
    },
    "splashcaster": {
      "subProfessionId": "splashcaster",
      "subProfessionName": "스플래시 캐스터",
      "subProfessionCatagory": 33
    },
    "funnel": {
      "subProfessionId": "funnel",
      "subProfessionName": "메카 캐스터",
      "subProfessionCatagory": 34
    },
    "phalanx": {
      "subProfessionId": "phalanx",
      "subProfessionName": "진법 캐스터",
      "subProfessionCatagory": 35
    },
    "mystic": {
      "subProfessionId": "mystic",
      "subProfessionName": "미스틱 캐스터",
      "subProfessionCatagory": 36
    },
    "chain": {
      "subProfessionId": "chain",
      "subProfessionName": "체인 캐스터",
      "subProfessionCatagory": 37
    },
    "blastcaster": {
      "subProfessionId": "blastcaster",
      "subProfessionName": "블래스트 캐스터",
      "subProfessionCatagory": 38
    },
    "physician": {
      "subProfessionId": "physician",
      "subProfessionName": "메딕",
      "subProfessionCatagory": 39
    },
    "ringhealer": {
      "subProfessionId": "ringhealer",
      "subProfessionName": "멀티 타겟 메딕",
      "subProfessionCatagory": 40
    },
    "healer": {
      "subProfessionId": "healer",
      "subProfessionName": "테라피스트",
      "subProfessionCatagory": 41
    },
    "wandermedic": {
      "subProfessionId": "wandermedic",
      "subProfessionName": "방랑 메딕",
      "subProfessionCatagory": 42
    },
    "slower": {
      "subProfessionId": "slower",
      "subProfessionName": "감속자",
      "subProfessionCatagory": 43
    },
    "underminer": {
      "subProfessionId": "underminer",
      "subProfessionName": "약화자",
      "subProfessionCatagory": 44
    },
    "bard": {
      "subProfessionId": "bard",
      "subProfessionName": "음유시인",
      "subProfessionCatagory": 45
    },
    "blessing": {
      "subProfessionId": "blessing",
      "subProfessionName": "비호자",
      "subProfessionCatagory": 46
    },
    "summoner": {
      "subProfessionId": "summoner",
      "subProfessionName": "소환사",
      "subProfessionCatagory": 47
    },
    "craftsman": {
      "subProfessionId": "craftsman",
      "subProfessionName": "기능공",
      "subProfessionCatagory": 48
    },
    "executor": {
      "subProfessionId": "executor",
      "subProfessionName": "처형자",
      "subProfessionCatagory": 49
    },
    "pusher": {
      "subProfessionId": "pusher",
      "subProfessionName": "추격자",
      "subProfessionCatagory": 50
    },
    "stalker": {
      "subProfessionId": "stalker",
      "subProfessionName": "매복자",
      "subProfessionCatagory": 51
    },
    "hookmaster": {
      "subProfessionId": "hookmaster",
      "subProfessionName": "후크마스터",
      "subProfessionCatagory": 52
    },
    "geek": {
      "subProfessionId": "geek",
      "subProfessionName": "기인",
      "subProfessionCatagory": 53
    },
    "merchant": {
      "subProfessionId": "merchant",
      "subProfessionName": "상인",
      "subProfessionCatagory": 54
    },
    "traper": {
      "subProfessionId": "traper",
      "subProfessionName": "함정술사",
      "subProfessionCatagory": 55
    },
    "dollkeeper": {
      "subProfessionId": "dollkeeper",
      "subProfessionName": "인형사",
      "subProfessionCatagory": 56
    },
    "incantationmedic": {
      "subProfessionId": "incantationmedic",
      "subProfessionName": "주술 메딕",
      "subProfessionCatagory": 57
    },
    "agent": {
      "subProfessionId": "agent",
      "subProfessionName": "에이전트",
      "subProfessionCatagory": 58
    }
  };

  return list[eng]['subProfessionName'];
}

String proSelector(String eng) {
  String result = '';
  switch (eng) {
    case 'MEDIC':
      {
        result = '메딕';
        break;
      }
    case 'WARRIOR':
      {
        result = '가드';
        break;
      }
    case 'SPECIAL':
      {
        result = '스페셜리스트';
        break;
      }
    case 'SNIPER':
      {
        result = '스나이퍼';
        break;
      }
    case 'PIONEER':
      {
        result = '뱅가드';
        break;
      }
    case 'TANK':
      {
        result = '디펜더';
        break;
      }
    case 'CASTER':
      {
        result = '캐스터';
        break;
      }
    case 'SUPPORT':
      {
        result = '서포터';
        break;
      }
  }

  return result;
}
