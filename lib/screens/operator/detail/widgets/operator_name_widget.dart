import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class OperatorName extends StatefulWidget {
  const OperatorName({
    super.key,
    required this.name,
  });

  final String name;

  @override
  State<OperatorName> createState() => _OperatorNameState();
}

class _OperatorNameState extends State<OperatorName> {
  final List<double> _stops = [
    0.05,
    0.3,
    0.5,
    0.7,
    0.95,
  ];
  final List<Color> _blue = [
    Colors.blueAccent.withOpacity(0.5),
    Colors.yellow.withOpacity(0.5),
    Colors.white.withOpacity(0),
    Colors.teal.withOpacity(0.5),
    Colors.blueAccent.withOpacity(0.5),
  ];
  final List<Color> _red = [
    Colors.yellow.withOpacity(0.5),
    Colors.redAccent.withOpacity(0.5),
    Colors.white.withOpacity(0),
    Colors.orange.withOpacity(0.5),
    Colors.redAccent.withOpacity(0.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size5,
                horizontal: Sizes.size20,
              ),
              decoration:
                  widget.name.contains("(한정)") || widget.name.contains("[한정]")
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size20),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, Sizes.size3),
                              blurRadius: Sizes.size2,
                              spreadRadius: Sizes.size1,
                              color: Colors.black12,
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            stops: _stops,
                            colors: widget.name.contains("(한정)") ? _blue : _red,
                          ),
                        )
                      : BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Sizes.size20),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, Sizes.size3),
                              blurRadius: Sizes.size2,
                              spreadRadius: Sizes.size1,
                              color: Colors.black12,
                            ),
                          ],
                        ),
              child: Text(
                widget.name.replaceAll(" (한정)", "").replaceAll(" [한정]", ""),
                textAlign: TextAlign.center,
                style:
                    widget.name.contains("(한정)") || widget.name.contains("[한정]")
                        ? TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size20,
                            fontFamily: FontFamily.nanumGothic,
                            fontWeight: FontWeight.w700,
                            shadows: [
                              const Shadow(
                                blurRadius: Sizes.size14,
                              ),
                              Shadow(
                                blurRadius: Sizes.size10,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          )
                        : TextStyle(
                            color: Colors.blueGrey.shade700,
                            fontSize: Sizes.size20,
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
