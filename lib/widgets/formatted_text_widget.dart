import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/tags_cubit.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/tools/stack.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _closeSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    var tagState = context.read<TagsCubit>().state;

    List<List<Widget>> widgets = [];
    List<String> lines = text.split('\n');
    int line = -1;

    for (var singleLineText in lines) {
      widgets.add([]);
      line += 1;

      // Separate by tags -> parts
      RegExp separator = RegExp(r"<[^<>]*[@$\/][^<>]*>");
      List<String> parts = [];
      int lastIndex = 0;
      for (Match match in separator.allMatches(singleLineText)) {
        if (lastIndex != match.start) {
          parts.add(singleLineText.substring(lastIndex, match.start).trim());
        }
        parts.add(match.group(0)!);
        lastIndex = match.end;
      }
      if (lastIndex != singleLineText.length) {
        parts.add(singleLineText.substring(lastIndex).trim());
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
          if (tagState.richTextTags!.keys.contains(newWord)) {
            // Analysis //
            // Case of TagRichText
            tagsStack.push(newWord);
          } else if (tagState.termTags!.keys.contains(newWord)) {
            // Analysis //
            // Case of TagTermDescription
            tagsStack.push(newWord);
          } else if (newWord == '</>') {
            // Analysis //
            // Case of </>
            if (tagsStack.isNotEmpty) {
              tagsStack.pop();
            }
          } else {
            // Fill widgets //
            // Case of normal text
            if (tagsStack.isEmpty) {
              widgets[line].add(AppFont(
                newWord,
                color: Colors.black87,
              ));
            } else {
              // Case of text which wrap by tag
              if (tagState.richTextTags!.keys.contains(tagsStack.peek)) {
                var colorStr = tagState.richTextTags![tagsStack.peek]!.color;
                if (colorStr == 'FFFFFF') colorStr = '0098DC';
                var colorVal = 0xff000000 + int.parse(colorStr, radix: 16);

                widgets[line].add(
                  AppFont(
                    newWord,
                    color: Color(colorVal),
                  ),
                );
              } else if (tagState.termTags!.keys.contains(tagsStack.peek)) {
                final name =
                    tagState.termTags![tagsStack.peek]!.termName!.substring(0);
                final msg = tagState.termTags![tagsStack.peek]!.description!
                    .substring(0);
                widgets[line].add(
                  GestureDetector(
                    onTap: () {
                      _closeSnackBar(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonSubTitleWidget(text: name),
                              Gaps.v5,
                              FormattedTextWidget(text: msg, center: false),
                            ],
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.white,
                          duration: const Duration(seconds: 10),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.blueGrey.shade700,
                              width: Sizes.size2,
                            ),
                            borderRadius: BorderRadius.circular(Sizes.size20),
                          ),
                          action: SnackBarAction(
                            label: '닫기',
                            onPressed: () {
                              try {
                                _closeSnackBar(context);
                              } catch (_) {}
                            },
                          ),
                        ),
                      );
                    },
                    child: AppFont(
                      newWord,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
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
