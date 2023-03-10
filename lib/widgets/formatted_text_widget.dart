import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/tools/stack.dart';
import 'package:flutter/material.dart';

class FormattedTextWidget extends StatelessWidget {
  final String text;
  final Map<String, dynamic> variables;
  final bool center;

  const FormattedTextWidget({
    super.key,
    required this.text,
    this.variables = const {},
    this.center = true,
  });

  @override
  Widget build(BuildContext context) {
    const List<String> tags = [
      '<@ba.kw>',
      '<@ba.talpu>',
      '<@ba.rem>',
      '<@ba.vdown>',
      '<@ba.vup>',
      '<\$ba.buffres>',
      '<\$ba.camou>',
      '<\$ba.cold>',
      '<\$ba.inspire>',
      '<\$ba.invisible>',
      '<\$ba.protect>',
      '<\$ba.root>',
      '<\$ba.sleep>',
      '<\$ba.sluggish>',
      '<\$ba.stun>',
      '<\$ba.shield>',
      '<\$ba.binding>',
      '<\$ba.dt.neural>',
      '<\$ba.charged>',
      '<\$ba.strong>',
      '<\$ba.dt.element>',
      '<\$ba.fragile>',
      '<\$ba.frozen>',
      '<\$ba.overdrive>',
      '<\$ba.debuff>',
      '<\$ba.levitate>',
      '</>',
    ];

    List<List<Widget>> widgets = [];
    List<String> lines = text.split('\n');
    int line = -1;

    for (var singleLineText in lines) {
      widgets.add([]);
      line += 1;

      // Separate by tags -> parts
      RegExp separator = RegExp(r"<.*?>");
      List<String> parts = [];
      int lastIndex = 0;
      for (Match match in separator.allMatches(singleLineText)) {
        if (lastIndex != match.start) {
          parts.add(singleLineText.substring(lastIndex, match.start));
        }
        parts.add(match.group(0)!);
        lastIndex = match.end;
      }
      if (lastIndex != singleLineText.length) {
        parts.add(singleLineText.substring(lastIndex));
      }

      // Analyse using stack
      DSStack<String> tagsStack = DSStack<String>();
      for (var part in parts) {
        for (var word in part.split(' ')) {
          if (word == '' || word == ' ') continue;
          var newWord = word;
          // Case of variable -> replace newWord
          if (word.contains('{') && word.contains('}')) {
            var isNegative = false;
            // Variable extraction
            var variable = word
                .substring(word.indexOf('{') + 1, word.indexOf('}'))
                .split(':')
                .first
                .toLowerCase();
            // Check negative variable
            if (variable.contains('-')) {
              isNegative = true;
              variable = variable.replaceAll('-', '');
            }
            double value;
            if (isNegative) {
              value = -variables[variable];
            } else {
              value = variables[variable];
            }
            // Variable formatting
            String valueString;
            if (word.contains(':0%') || word.contains(':0.0%')) {
              valueString =
                  '${(value * 100).toStringAsFixed(1).replaceAll('.0', '')}%';
            } else {
              valueString = value.toString().replaceAll('.0', '');
            }
            // Replace variable space to newWord
            newWord = word.replaceRange(
                word.indexOf('{'), word.indexOf('}') + 1, valueString);
          }
          // Analysis and fill widgets
          if (tags.contains(newWord)) {
            // Analysis //
            // Case of tag
            if (newWord != '</>') {
              tagsStack.push(newWord);
            } else {
              if (tagsStack.isNotEmpty) {
                tagsStack.pop();
              }
            }
          } else {
            // Fill widgets //
            // Case of normal text
            if (tagsStack.isEmpty) {
              widgets[line].add(Text(
                newWord,
                style: const TextStyle(
                  fontFamily: FontFamily.nanumGothic,
                  fontSize: Sizes.size12,
                  color: Colors.black87,
                ),
              ));
            } else {
              // Case of text which wrap by tag
              switch (tagsStack.peek) {
                case '<@ba.rem>':
                  widgets[line].add(Text(
                    newWord,
                    style: TextStyle(
                      fontFamily: FontFamily.nanumGothic,
                      fontSize: Sizes.size12,
                      color: Colors.yellow.shade800,
                    ),
                  ));
                  break;
                case '<@ba.kw>':
                case '<@ba.talpu>':
                case '<@ba.vup>':
                  widgets[line].add(Text(
                    newWord,
                    style: const TextStyle(
                      fontFamily: FontFamily.nanumGothic,
                      fontSize: Sizes.size12,
                      color: Colors.blue,
                    ),
                  ));
                  break;
                case '<@ba.vdown>':
                  widgets[line].add(Text(
                    newWord,
                    style: const TextStyle(
                      fontFamily: FontFamily.nanumGothic,
                      fontSize: Sizes.size12,
                      color: Colors.red,
                    ),
                  ));
                  break;
                case '<\$ba.buffres>':
                case '<\$ba.camou>':
                case '<\$ba.cold>':
                case '<\$ba.inspire>':
                case '<\$ba.invisible>':
                case '<\$ba.protect>':
                case '<\$ba.root>':
                case '<\$ba.sleep>':
                case '<\$ba.sluggish>':
                case '<\$ba.stun>':
                case '<\$ba.shield>':
                case '<\$ba.binding>':
                case '<\$ba.dt.neural>':
                case '<\$ba.charged>':
                case '<\$ba.strong>':
                case '<\$ba.dt.element>':
                case '<\$ba.fragile>':
                case '<\$ba.frozen>':
                case '<\$ba.overdrive>':
                case '<\$ba.debuff>':
                case '<\$ba.levitate>':
                  // 추후 기능 추가
                  widgets[line].add(Text(
                    newWord,
                    style: const TextStyle(
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: FontWeight.w700,
                      fontSize: Sizes.size12,
                      color: Colors.grey,
                    ),
                  ));
                  break;
              }
            }
          }
        }
      }
    }

    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < line + 1; i++)
          if (widgets[i].isNotEmpty)
            Wrap(
              spacing: Sizes.size3,
              children: widgets[i],
            ),
      ],
    );
  }
}

Map<String, double> boardListAndDurationToMap({
  required List<BlackboardModel> blackboards,
  double? duration,
}) {
  Map<String, double> result = {
    for (var data in blackboards) data.key!: data.value!
  };
  if (!result.keys.contains('duration') && duration != null) {
    result['duration'] = duration;
  }

  return result;
}
