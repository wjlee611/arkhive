import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/setting_cubit.dart';
import 'package:arkhive/cubit/splash_cubit.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingDBRegionWidget extends StatelessWidget {
  const SettingDBRegionWidget({super.key});

  void _onSelected(BuildContext context, Region dbRegion) {
    final cubit = context.read<SettingCubit>();
    if (cubit.state.settings.dbRegion == dbRegion) return;

    cubit.changeRegion(dbRegion: dbRegion);
    context.read<SplashCubit>().changeLoadStatus(SplashState.init);

    context.replace('/');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) => PopupMenuButton(
        initialValue: state.settings.dbRegion,
        onSelected: (dbRegion) => _onSelected(context, dbRegion),
        offset: const Offset(0, 0),
        icon: BlocBuilder<SettingCubit, SettingState>(
          buildWhen: (previous, current) =>
              previous.settings.dbRegion != current.settings.dbRegion,
          builder: (context, state) => Container(
            child: AppFont(
              state.settings.dbRegion?.path ?? Region.kr.path,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: Sizes.size5,
            color: Colors.blueGrey.shade700,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.size10)),
        ),
        color: Theme.of(context).primaryColor,
        elevation: 0,
        itemBuilder: (context) => [
          PopupMenuItem(
            value: Region.kr,
            child: AppFont(
              Region.kr.path,
              fontSize: Sizes.size14,
            ),
          ),
          PopupMenuItem(
            value: Region.cn,
            child: AppFont(
              Region.cn.path,
              fontSize: Sizes.size14,
            ),
          ),
        ],
      ),
    );
  }
}
