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
          bool isDuration = false;
          bool isVariable = false;
          bool isNoMark = false;
          if (word.contains('{') && word.contains('}')) {
            isVariable = true;
            var variable = word
                .substring(word.indexOf('{') + 1, word.indexOf('}'))
                .split(':')
                .first
                .replaceAll('+', '')
                .replaceAll('-', '')
                .toLowerCase();
            if (variable.contains('duration') ||
                variable.contains('time') ||
                variable.contains('sec')) {
              isDuration = true;
            }
            if (variable.contains('@') ||
                variable.contains('scale') ||
                variable.contains('value') ||
                variable.contains('damage')) {
              isNoMark = true;
            }
            var value = variables[variable];
            String valueString;
            if (word.contains(':0%') || word.contains(':0.0%')) {
              valueString =
                  '${(value * 100).toStringAsFixed(1).replaceAll('.0', '')}%';
            } else {
              valueString = value.toString().replaceAll('.0', '');
            }
            newWord = word.replaceRange(
                word.indexOf('{'), word.indexOf('}') + 1, valueString);
          }
          if (tags.contains(newWord)) {
            // tag
            if (newWord != '</>') {
              tagsStack.push(newWord);
            } else {
              if (tagsStack.isNotEmpty) {
                tagsStack.pop();
              }
            }
          } else {
            // normal
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
              // wrap by tag
              switch (tagsStack.peek) {
                case '<@ba.kw>':
                case '<@ba.talpu>':
                  widgets[line].add(Text(
                    newWord,
                    style: const TextStyle(
                      fontFamily: FontFamily.nanumGothic,
                      fontSize: Sizes.size12,
                      color: Colors.blue,
                    ),
                  ));
                  break;
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
                case '<@ba.vdown>':
                  if (!newWord.contains('+') && !newWord.contains('-')) {
                    if (!isDuration && !isNoMark && isVariable) {
                      newWord = '-$newWord';
                    }
                  }
                  widgets[line].add(Text(
                    newWord,
                    style: const TextStyle(
                      fontFamily: FontFamily.nanumGothic,
                      fontSize: Sizes.size12,
                      color: Colors.red,
                    ),
                  ));
                  break;
                case '<@ba.vup>':
                  if (!newWord.contains('+') && !newWord.contains('-')) {
                    if (!isDuration && !isNoMark && isVariable) {
                      newWord = '+$newWord';
                    }
                  }
                  widgets[line].add(Text(
                    newWord,
                    style: const TextStyle(
                      fontFamily: FontFamily.nanumGothic,
                      fontSize: Sizes.size12,
                      color: Colors.blue,
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
          Wrap(
            spacing: Sizes.size3,
            children: widgets[i],
          ),
      ],
    );
  }
}

Map<String, double> blackboardListToMap(
    {required List<BlackboardModel> blackboards}) {
  Map<String, double> result = {
    for (var data in blackboards) data.key!: data.value!
  };

  return result;
}
