import 'package:bloc_app_example/bloc_observer.dart';
import 'package:bloc_app_example/core/router/app_router.dart';
import 'package:bloc_app_example/features/posts/presentation/blocs/add_delete_update/add_delete_update_bloc.dart';
import 'package:bloc_app_example/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'dependencies_injector.dart' as sl;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  Bloc.observer = AppBlocObserver();
  await sl.ServiceLocator.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get appScheme => FlexScheme.espresso;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl.getIt<PostsBloc>()),
        BlocProvider(create: (_) => sl.getIt<AddDeleteUpdateBloc>())
      ],
      child: MaterialApp.router(
        routerConfig: appRoutes,
        debugShowCheckedModeBanner: false,
        title: 'Bloc Example App',
        theme: FlexThemeData.light(scheme: appScheme),
        darkTheme: FlexThemeData.dark(scheme: appScheme),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
