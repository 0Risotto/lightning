import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:lightning_/core/configs/theme/app_theme.dart';
import 'package:lightning_/firebase_options.dart';
import 'package:lightning_/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:lightning_/presentation/splash/pages/splash.dart';
import 'package:lightning_/service_locator.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ThemeCubit())],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
            theme: AppTheme.lightTheme,
            themeMode: mode,
            darkTheme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            home: const SplashPage()),
      ),
    );
  }
}
