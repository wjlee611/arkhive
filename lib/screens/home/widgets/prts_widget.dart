import 'package:arkhive/bloc/versionCheck/version_check_bloc.dart';
import 'package:arkhive/bloc/versionCheck/version_check_event.dart';
import 'package:arkhive/bloc/versionCheck/version_check_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/update/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PRTSWidget extends StatefulWidget {
  const PRTSWidget({super.key});

  @override
  State<PRTSWidget> createState() => _PRTSWidgetState();
}

class _PRTSWidgetState extends State<PRTSWidget> {
  @override
  void initState() {
    super.initState();

    // Version check once
    context.read<VersionCheckBloc>().add(const VersionCheckEvent());
  }

  String prtsMessage(VersionCheckStateABS state) {
    if (state is VersionCheckInitState) {
      return "초기화 중...";
    }
    if (state is VersionCheckLoadingState) {
      return "업데이트를 확인 중 입니다...";
    }
    if (state is VersionCheckErrorState) {
      return "업데이트 정보를 받아오는 데 실패했습니다.\n잠시 후 다시 시도해주세요.";
    }

    var loadedState = state as VersionCheckLoadedState;
    if (loadedState.targetAPPVersion != '') {
      return "중요 업데이트가 있습니다.\n스토어에서 업데이트를 진행해주세요.";
    }
    if (loadedState.targetDBVersion != '') {
      return "업데이트가 발견되었습니다.\n여기를 누르셔서 진행하실 수 있습니다.";
    }

    return "어서오세요, 박사님.";
  }

  void _onTapUpdater(VersionCheckStateABS state) {
    if (state is! VersionCheckLoadedState) return;
    // if (state.targetDBVersion == '') return;

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            BlocProvider.value(
          value: BlocProvider.of<VersionCheckBloc>(super.context),
          child: const UpdateScreen(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VersionCheckBloc, VersionCheckStateABS>(
      builder: (context, state) => GestureDetector(
        onTap: () => _onTapUpdater(state),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.shade100,
                blurRadius: Sizes.size5,
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              Container(
                color: Colors.blueGrey.shade600,
                padding: const EdgeInsets.all(Sizes.size5),
                child: Image.asset(
                  'assets/images/prts.png',
                  width: Sizes.size48,
                  height: Sizes.size48,
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size10),
                    child: Text(
                      prtsMessage(state),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: Sizes.size12,
                        fontFamily: FontFamily.nanumGothic,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
