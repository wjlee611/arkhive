import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/setting_cubit.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/asset_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class TutoTextModel {
  final String title;
  final String body;

  const TutoTextModel({
    required this.title,
    required this.body,
  });
}

class TutorialScreen extends StatelessWidget {
  final bool isFirst;

  TutorialScreen({
    super.key,
    this.isFirst = false,
  });

  final PageDecoration _pageDecoration = PageDecoration(
    fullScreen: true,
    imageFlex: 4,
    bodyFlex: 3,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: Sizes.size20,
      fontWeight: FontWeight.w700,
      fontFamily: FontFamily.nanumGothic,
      shadows: [
        Shadow(
          color: Colors.blueGrey.shade800,
          blurRadius: Sizes.size6,
        ),
        Shadow(
          color: Colors.blueGrey.shade800,
          blurRadius: Sizes.size6,
        ),
      ],
    ),
    bodyTextStyle: TextStyle(
      color: Colors.white,
      fontSize: Sizes.size12,
      fontFamily: FontFamily.nanumGothic,
      shadows: [
        Shadow(
          color: Colors.yellow.shade800,
          blurRadius: Sizes.size3,
        ),
        Shadow(
          color: Colors.yellow.shade800,
          blurRadius: Sizes.size3,
        ),
      ],
    ),
  );

  final List<TutoTextModel> _texts = const [
    TutoTextModel(
      title: '안녕하세요, 박사님.\nArkhive 시스템을 소개드립니다.',
      body:
          '\n[ 1 ]\n즐겨찾기에 등록된 데이터를 홈 화면에서 빠르게 액세스 할 수 있습니다.\n\n[ 2 ]\n즐겨찾기에 등록된 데이터를 빠르게 삭제하실 수 있습니다.',
    ),
    TutoTextModel(
      title: '자료를 열람하실 때,\n유용한 도구를 소개드립니다.',
      body:
          '\n[ 1 ]\n데이터의 정렬, 필터링 기능을 제공합니다.\n\n[ 2 ]\n입력된 검색어가 포함된 데이터만을 표시합니다.',
    ),
    TutoTextModel(
      title: '이력서를 열람하실 때,\n유용한 도구를 소개드립니다.',
      body:
          '\n[ 1 ]\n오퍼레이터의 세부 스펙을 변경할 수 있는 화면이 열리고 닫히게합니다.\n\n[ 2 ]\n오퍼레이터의 정예화, 스킬, 모듈 육성에 필요한 모든 재료를 보여줍니다.',
    ),
    TutoTextModel(
      title: '잠재적인 스펙을 자유롭게\n열람하실 수 있습니다.',
      body: '\n잠재능력, 정예화, 레벨, 신뢰도의 수치를 조정할 수 있으며, 변화된 스탯은 실시간으로 확인할 수 있습니다.',
    ),
    TutoTextModel(
      title: '유기적인 데이터베이스의\n유용한 도구를 소개드립니다.',
      body:
          '\n[ 1 ]\n펭귄 물류 분석 부서의 데이터 서버를 변경할 수 있습니다.\n(CN: 중국서버, US: 북미서버)\n\n[ 2 ]\n데이터를 즐겨찾기에 추가/삭제할 수 있습니다.\n\n열람하고있는 파일에서 다른 파일로 유기적으로 이동할 수 있습니다.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppFont(
          '가이드',
          color: Colors.white,
          fontSize: Sizes.size16,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: IntroductionScreen(
        pages: [
          for (int i = 0; i < _texts.length; i++)
            PageViewModel(
              title: _texts[i].title,
              body: _texts[i].body,
              decoration: _pageDecoration,
              image: AssetImageWidget(
                path: 'assets/images/tutorials/arkhive_tutorial_${i + 1}.jpg',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                alignment:
                    i == 0 ? Alignment.bottomCenter : Alignment.topCenter,
              ),
            ),
        ],
        showSkipButton: true,
        skip: const AppFont(
          'Skip',
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        next: Icon(
          Icons.arrow_forward,
          color: Colors.yellow.shade800,
        ),
        done: AppFont(
          'Done',
          color: Colors.yellow.shade800,
          fontWeight: FontWeight.w700,
        ),
        onDone: () {
          if (isFirst) {
            context.read<SettingCubit>().firstRun();
            context.replace('/route');
          } else {
            Navigator.pop(context);
          }
        },
        curve: Curves.fastLinearToSlowEaseIn,
        dotsDecorator: DotsDecorator(
          size: const Size(10.0, 10.0),
          color: Colors.yellow.shade100,
          activeColor: Colors.yellow.shade800,
          activeSize: const Size(22.0, 10.0),
          activeShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Sizes.size24)),
          ),
        ),
        dotsContainerDecorator: ShapeDecoration(
          color: Colors.blueGrey.shade800.withOpacity(0.5),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Sizes.size20),
            ),
          ),
        ),
      ),
    );
  }
}
