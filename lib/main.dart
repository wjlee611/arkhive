import 'package:arkhive/bloc/screen_bloc.dart';
import 'package:arkhive/bloc/versionCheck/version_check_bloc.dart';
import 'package:arkhive/firebase_options.dart';
import 'package:arkhive/screens/routes/routes_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize firebase service
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.debug,
  );

  runApp(const Arkhive());
}

class Arkhive extends StatelessWidget {
  const Arkhive({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arkhive',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ScreenBloc(),
          ),
          BlocProvider(
            create: (context) => VersionCheckBloc(
              currAPPVersion: '1.0.0',
            ),
          ),
        ],
        child: const RoutesScreen(),
      ),
    );
  }
}
