import 'package:arkhive/constants/app_data.dart';

enum EOperatorPosition {
  melee('근거리'),
  ranged('원거리'),
  noResult(AppData.nullStr);

  final String value;

  const EOperatorPosition(this.value);
}

EOperatorPosition operatorPositionSelector(String range) {
  switch (range) {
    case 'MELEE':
      return EOperatorPosition.melee;
    case 'RANGED':
      return EOperatorPosition.ranged;
    default:
      return EOperatorPosition.noResult;
  }
}
