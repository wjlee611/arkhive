import 'package:arkhive/bloc/screen_bloc.dart';
import 'package:arkhive/screens/routes/routes_screen.dart';
import 'package:arkhive/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ArkhiveApp extends StatefulWidget {
  const ArkhiveApp({super.key});

  @override
  State<ArkhiveApp> createState() => _ArkhiveAppState();
}

class _ArkhiveAppState extends State<ArkhiveApp> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/route',
          builder: (context, state) => BlocProvider(
            create: (context) => ScreenBloc(),
            child: const RoutesScreen(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Arkhive',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
