import 'dart:convert';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/update/update_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PRTSWidget extends StatefulWidget {
  const PRTSWidget({super.key});

  @override
  State<PRTSWidget> createState() => _PRTSWidgetState();
}

class _PRTSWidgetState extends State<PRTSWidget> {
  @override
  void initState() {
    super.initState();
    _updateChecker();
  }

  void _updateChecker() async {
    DatabaseReference databaseRef =
        FirebaseDatabase.instance.ref("update_checker");
    // Get data
    DatabaseEvent databaseEvent = await databaseRef.once();
    try {
      print(jsonEncode(databaseEvent.snapshot.value));
    } catch (_) {}
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
    return GestureDetector(
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
            const Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.size10),
                  child: Text(
                    "데이터 초기화 완료.\n어서오세요, 박사님.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
    );
  }
}
