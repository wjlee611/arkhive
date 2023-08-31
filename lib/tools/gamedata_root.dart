import 'package:arkhive/cubit/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Region {
  kr('ko_KR'),
  cn('zh_CN');

  final String path;

  const Region(this.path);
}

String getGameDataRoot(Region dbRegion) {
  return 'assets/data/${dbRegion.path}/gamedata/';
}

Region getRegion(BuildContext context) {
  return context.read<SettingCubit>().state.settings.dbRegion ?? Region.kr;
}
