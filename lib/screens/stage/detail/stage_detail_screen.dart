import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/stage_model.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';

class StageDetailScreen extends StatefulWidget {
  const StageDetailScreen({
    super.key,
    required this.stage,
  });

  final StageModel stage;

  @override
  State<StageDetailScreen> createState() => _StageDetailScreenState();
}

class _StageDetailScreenState extends State<StageDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.stage.code ?? '???',
          style: const TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade700,
        actions: [
          IconButton(
            onPressed: () {
              //TODO: 즐겨찾기 추가/삭제 알고리즘 추가
            },
            icon: Icon(
              Icons.star_border_outlined,
              color: Colors.yellow.shade700,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              CommonTitleWidget(
                text: widget.stage.name ?? '???',
                color: Colors.yellow.shade800,
              ),
              if (widget.stage.description != null)
                Column(
                  children: [
                    Gaps.v10,
                    FormattedTextWidget(
                      text: widget.stage.description!,
                      center: false,
                    ),
                  ],
                ),
              Gaps.v10,
              SanityInfoTag(
                title: '소모 이성',
                value: widget.stage.apCost ?? -1,
              ),
              Gaps.v5,
              SanityInfoTag(
                title: '반환 이성',
                value: widget.stage.apFailReturn ?? -1,
              ),
              Gaps.v20,
              if (widget.stage.stageDropInfo != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonTitleWidget(text: '드랍 아이템'),
                    Gaps.v10,
                    for (var item in widget.stage.stageDropInfo!.rewords)
                      Text('${item.type}(${item.dropType}) - ${item.id}')
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SanityInfoTag extends StatelessWidget {
  const SanityInfoTag({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: Sizes.size2,
            spreadRadius: Sizes.size1 / 10,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: Sizes.size24,
            width: Sizes.size72,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.blueGrey.shade800,
                  fontSize: Sizes.size10,
                  fontFamily: FontFamily.nanumGothic,
                ),
              ),
            ),
          ),
          Container(
            height: Sizes.size24,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size5),
            color: Colors.yellow.shade800,
            child: Center(
              child: Text(
                value == -1 ? 'N/A' : value.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size14,
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
