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
    List<TextSpan> textSpans = [];

    RegExp separator = RegExp(r"<.*?>");
    List<String> parts = [];
    int lastIndex = 0;
    for (Match match in separator.allMatches(text)) {
      if (lastIndex != match.start) {
        parts.add(text.substring(lastIndex, match.start));
      }
      parts.add(match.group(0)!);
      lastIndex = match.end;
    }
    if (lastIndex != text.length) {
      parts.add(text.substring(lastIndex));
    }

    const List<String> tags = [
      '<@ba.kw>',
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

    DSStack<String> tagsStack = DSStack<String>();
    List<Widget> widgets = [];
    for (var part in parts) {
      for (var word in part.split(' ')) {
        if (word == '' || word == ' ') continue;
        var newWord = word;
        bool isDuration = false;
        bool isVariable = false;
        if (word.contains('{') && word.contains('}')) {
          isVariable = true;
          var variable = word
              .substring(word.indexOf('{') + 1, word.indexOf('}'))
              .split(':')
              .first;
          if (variable.contains('duration') || variable.contains('time')) {
            isDuration = true;
          }
          var value = variables[variable];
          if (word.contains(':0%')) {
            newWord =
                '${(value * 100).toStringAsFixed(1).replaceAll('.0', '')}%';
          } else {
            newWord = value.toString().replaceAll('.0', '');
          }
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
            widgets.add(Text(
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
                widgets.add(Text(
                  newWord,
                  style: const TextStyle(
                    fontFamily: FontFamily.nanumGothic,
                    fontSize: Sizes.size12,
                    color: Colors.blue,
                  ),
                ));
                break;
              case '<@ba.rem>':
                widgets.add(Text(
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
                  if (!isDuration && isVariable) {
                    newWord = '-$newWord';
                  }
                }
                widgets.add(Text(
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
                  if (!isDuration && isVariable) {
                    newWord = '+$newWord';
                  }
                }
                widgets.add(Text(
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
                widgets.add(Text(
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

    return Wrap(
      spacing: Sizes.size3,
      children: widgets,
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
