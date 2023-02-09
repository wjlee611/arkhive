import 'package:arkhive/global_data.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class NewScreenListTile extends StatelessWidget {
  const NewScreenListTile({
    super.key,
    required this.id,
    required this.isSelected,
    required this.icon,
    required this.title,
    required this.newScreen,
  });

  final String id;
  final bool isSelected;
  final IconData icon;
  final String title;
  final Widget newScreen;

  Route _createRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void _onTap(BuildContext context) {
    Scaffold.of(context).closeDrawer();
    if (!isSelected) {
      Navigator.pushReplacement(context, _createRoute(newScreen));
      GlobalData().screen = id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Colors.yellow.shade700 : Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.yellow.shade700 : Colors.white,
          fontFamily: FontFamily.nanumGothic,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
      onTap: () => _onTap(context),
    );
  }
}
