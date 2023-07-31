import 'package:arkhive/cubit/penguin_cubit.dart';
import 'package:arkhive/cubit/range_cubit.dart';
import 'package:arkhive/cubit/splash_cubit.dart';
import 'package:arkhive/cubit/tags_cubit.dart';
import 'package:arkhive/screens/app.dart';
import 'package:arkhive/cubit/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  // initialize firebase service
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  //   androidProvider: AndroidProvider.debug,
  // );

  runApp(const Arkhive());
}

class Arkhive extends StatelessWidget {
  const Arkhive({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => SettingCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => TagsCubit(),
        ),
        BlocProvider(
          create: (context) => RangeCubit(),
        ),
        BlocProvider(
          create: (context) => PenguinCubit(),
        ),
      ],
      child: const ArkhiveApp(),
    );
  }
}
