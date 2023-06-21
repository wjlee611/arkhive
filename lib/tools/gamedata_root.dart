enum Lang {
  ko_KR,
  en_US,
}

String getGameDataRoot({Lang lang = Lang.ko_KR}) {
  String language = 'ko_KR';
  if (lang == Lang.en_US) {
    language = 'en_US';
  }

  return 'assets/data/$language/gamedata/';
}
