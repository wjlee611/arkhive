import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:flutter/material.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

class PosInfoCard extends StatelessWidget {
  const PosInfoCard({
    super.key,
    required this.operatorPos,
  });

  final String operatorPos;

  String _getPostionInfo(String position) {
    if (position == "전술가") return OperatorPositions.tactician;
    if (position == "돌격수") return OperatorPositions.charger;
    if (position == "척후병") return OperatorPositions.pioneer;
    if (position == "기수") return OperatorPositions.standardBearer;

    if (position == "명사수") return OperatorPositions.marksman;
    if (position == "명사수*") return OperatorPositions.marksman_1star;
    if (position == "포격사수") return OperatorPositions.artilleryman;
    if (position == "저격수") return OperatorPositions.deadeye;
    if (position == "헤비슈터") return OperatorPositions.heavyshooter;
    if (position == "산탄사수") return OperatorPositions.spreadshooter;
    if (position == "공성사수") return OperatorPositions.besieger;
    if (position == "투척수") return OperatorPositions.flinger;

    if (position == "드레드노트") return OperatorPositions.dreadnought;
    if (position == "드레드노트*") return OperatorPositions.dreadnought_1star;
    if (position == "로드") return OperatorPositions.lord;
    if (position == "공격수") return OperatorPositions.centurion;
    if (position == "교관") return OperatorPositions.instructor;
    if (position == "파이터") return OperatorPositions.fighter;
    if (position == "아츠 파이터") return OperatorPositions.artsFighter;
    if (position == "무사") return OperatorPositions.musha;
    if (position == "소드마스터") return OperatorPositions.swordmaster;
    if (position == "해방자") return OperatorPositions.liberator;
    if (position == "리퍼") return OperatorPositions.reaper;

    if (position == "코어 캐스터") return OperatorPositions.coreCaster;
    if (position == "스플래시 캐스터") return OperatorPositions.splashCaster;
    if (position == "메카 캐스터") return OperatorPositions.mechAccordCaster;
    if (position == "미스틱 캐스터") return OperatorPositions.mysticCaster;
    if (position == "체인 캐스터") return OperatorPositions.chainCaster;
    if (position == "진법 캐스터") return OperatorPositions.phalanxCaster;
    if (position == "블래스트 캐스터") return OperatorPositions.blastCaster;

    if (position == "프로텍터") return OperatorPositions.protector;
    if (position == "아츠 프로텍터") return OperatorPositions.artsProtector;
    if (position == "가디언") return OperatorPositions.guardian;
    if (position == "파수꾼") return OperatorPositions.sentinelIronGuard;
    if (position == "저거너트") return OperatorPositions.juggernaut;
    if (position == "포트리스") return OperatorPositions.fortress;
    if (position == "결전자") return OperatorPositions.duelist;

    if (position == "메딕") return OperatorPositions.singleMedic;
    if (position == "메딕*") return OperatorPositions.singleMedic_1star;
    if (position == "멀티 타겟 메딕") return OperatorPositions.multiTargetMedic;
    if (position == "테라피스트") return OperatorPositions.therapist;
    if (position == "방랑 메딕") return OperatorPositions.wanderingMedic;
    if (position == "주술 메딕") return OperatorPositions.incantationMedic;

    if (position == "처형자") return OperatorPositions.executor;
    if (position == "처형자*") return OperatorPositions.executor_1star;
    if (position == "후크마스터") return OperatorPositions.hookmaster;
    if (position == "추격자") return OperatorPositions.pushStroker;
    if (position == "매복자") return OperatorPositions.ambusher;
    if (position == "상인") return OperatorPositions.merchant;
    if (position == "함정술사") return OperatorPositions.trapmaster;
    if (position == "인형사") return OperatorPositions.dollkeeper;
    if (position == "기인") return OperatorPositions.geek;

    if (position == "감속자") return OperatorPositions.decelBinder;
    if (position == "소환사") return OperatorPositions.summoner;
    if (position == "기능공") return OperatorPositions.artificer;
    if (position == "약화자") return OperatorPositions.hexer;
    if (position == "음유시인") return OperatorPositions.bard;
    if (position == "비호자") return OperatorPositions.abjurer;

    return "not found";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.size20),
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
      child: Column(
        children: [
          Container(
            color: Colors.blueGrey.shade600,
            padding: const EdgeInsets.all(Sizes.size10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.accessibility_new_rounded,
                  color: Colors.yellow.shade700,
                  size: Sizes.size20,
                ),
                Gaps.h5,
                const Text(
                  "특성",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                    fontFamily: FontFamily.nanumGothic,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Sizes.size10),
            child: WrappedKoreanText(
              _getPostionInfo(operatorPos),
              style: const TextStyle(
                fontSize: Sizes.size14,
                fontFamily: FontFamily.nanumGothic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
