import 'package:arkhive/bloc/screen_bloc.dart';
import 'package:arkhive/cubit/setting_cubit.dart';
import 'package:arkhive/screens/routes/routes_screen.dart';
import 'package:arkhive/screens/splash/splash_screen.dart';
import 'package:arkhive/screens/tutorial/tutorial_screen.dart';
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
          path: '/tutorial',
          builder: (context, state) => TutorialScreen(isFirst: true),
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
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) => MaterialApp.router(
        routerConfig: _router,
        title: 'Arkhive',
        theme: state.settings.isDarkTheme == true
            ? ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.blueGrey.shade600,
                ),
                scaffoldBackgroundColor: const Color(0xff282828),
                appBarTheme: const AppBarTheme(
                  surfaceTintColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shadowColor: Color(0xff111111),
                ),
                primaryColor: const Color(0xff313131),
                shadowColor: const Color(0xff111111),
                textTheme: TextTheme(
                  bodyMedium: TextStyle(color: Colors.blueGrey.shade400),
                  bodySmall: const TextStyle(color: Color(0xffe5e5e5)),
                  labelMedium: const TextStyle(color: Colors.grey),
                  labelSmall: TextStyle(color: Colors.grey.shade500),
                ),
              )
            : ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.blueGrey.shade600,
                ),
                scaffoldBackgroundColor: const Color(0xffefefef),
                appBarTheme: const AppBarTheme(
                  surfaceTintColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shadowColor: Color(0xff111111),
                ),
                primaryColor: const Color(0xfff5f5f5),
                shadowColor: const Color(0xff999999),
                textTheme: TextTheme(
                  bodyMedium: TextStyle(color: Colors.blueGrey.shade800),
                  bodySmall: const TextStyle(color: Colors.black87),
                  labelMedium: const TextStyle(color: Colors.black54),
                  labelSmall: TextStyle(color: Colors.grey.shade700),
                ),
              ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
