import 'package:bloc_app_example/core/router/app_router.dart';
import 'package:bloc_app_example/core/themes/app_themes.dart';
import 'package:bloc_app_example/features/posts/presentation/blocs/add_delete_update/add_delete_update_bloc.dart';
import 'package:bloc_app_example/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dependencies_injector.dart' as sl;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.ServiceLocator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => sl.getIt<PostsBloc>()..add(GetPostsEvent())),
        BlocProvider(create: (_) => sl.getIt<AddDeleteUpdateBloc>())
      ],
      child: MaterialApp.router(
        routerConfig: appRoutes,
        // routeInformationParser: ,
        // routerDelegate: ,
        debugShowCheckedModeBanner: false,
        title: 'Bloc Example App',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
