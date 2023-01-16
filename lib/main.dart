import 'package:arkhive/screens/main_screen.dart';
import 'package:flutter/material.dart';
import './global_vars.dart' as globals;

void main() {
  // initialize data
  WidgetsFlutterBinding.ensureInitialized();

  if (globals.classedOperators[0].isEmpty) {
    globals.globalDataInitializer();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Arkhive',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
