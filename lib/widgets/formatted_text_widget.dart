import 'package:arkhive/models/common_models.dart';
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
    RegExp separator = RegExp(r"<.*?>.*?</>");

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

    for (String part in parts) {
      if (part.startsWith('<@')) {
        // variables text
        String tag = part.substring(0, part.indexOf('>') + 1);
        String value =
            part.substring(part.indexOf('>') + 1, part.indexOf('</>'));
        String varValue = '';
        String variable = '';

        if (value.contains(':')) {
          String format = value
              .substring(value.indexOf(':') + 1, value.indexOf('}'))
              .replaceAll('0', '');
          variable =
              value.substring(value.indexOf('{') + 1, value.indexOf(':'));
          varValue +=
              '${((variables[variable] * 100).toStringAsFixed(1) + format)}';
        } else if (value.contains('{')) {
          variable =
              value.substring(value.indexOf('{') + 1, value.indexOf('}'));
          varValue += '${variables[variable].toStringAsFixed(1)}';
        } else {
          varValue = value;
        }

        if (tag == "<@ba.vup>") {
          varValue = '+';
        } else if (tag == "<@ba.vdown>") {
          varValue = '-';
        }
        textSpans.add(
          TextSpan(
            text: varValue.replaceAll('.0', ''),
            style: TextStyle(
              color: tag == "<@ba.vdown>" ? Colors.red : Colors.blue,
            ),
          ),
        );
      } else if (part.startsWith('<\$')) {
        // link text
        String tag = part.substring(0, part.indexOf('>') + 1);
        String value =
            part.substring(part.indexOf('>') + 1, part.indexOf('</>'));
        switch (tag) {
          case '<\$ba.sluggish>':
            textSpans.add(
              TextSpan(
                text: value,
                style: const TextStyle(color: Colors.grey),
              ),
            );
            break;
        }
      } else {
        // default text
        textSpans.add(TextSpan(text: part));
      }
    }

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: textSpans,
      ),
      textAlign: center ? TextAlign.center : TextAlign.start,
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
