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

  void _onTapUpdater() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const UpdateScreen(),
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
        onTap: _onTapUpdater,
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
                      state is VersionCheckInitState
                          ? "초기화 중..."
                          : state is VersionCheckLoadingState
                              ? "업데이트를 확인 중 입니다..."
                              : state is VersionCheckErrorState
                                  ? "업데이트 정보를 받아오는 데 실패했습니다.\n인터넷 연결을 확인해주세요."
                                  : "어서오세요, 박사님.",
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
