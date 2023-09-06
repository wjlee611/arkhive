import 'package:arkhive/cubit/enemy_class_level_cubit.dart';
import 'package:arkhive/cubit/favorite_cubit.dart';
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

  runApp(const Arkhive());
}

class Arkhive extends StatelessWidget {
  const Arkhive({super.key});

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
          create: (context) => FavoriteCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => TagsCubit(),
        ),
        BlocProvider(
          create: (context) => RangeCubit(),
        ),
        BlocProvider(
          create: (context) => EnemyClassLevelCubit(),
        ),
        BlocProvider(
          create: (context) => PenguinCubit(),
        ),
      ],
      child: const ArkhiveApp(),
    );
  }
}
