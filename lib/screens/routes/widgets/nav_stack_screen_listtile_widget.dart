import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class StackScreenListTile extends StatelessWidget {
  const StackScreenListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.newScreen,
  });

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
    Navigator.push(context, _createRoute(newScreen));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: AppFont(
        title,
        color: Colors.white,
        fontSize: Sizes.size14,
      ),
      onTap: () => _onTap(context),
    );
  }
}
