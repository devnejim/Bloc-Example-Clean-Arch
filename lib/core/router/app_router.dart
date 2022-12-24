import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:bloc_app_example/features/posts/presentation/screens/error_screen.dart';
import 'package:bloc_app_example/features/posts/presentation/screens/post_comments.dart';
import 'package:bloc_app_example/features/posts/presentation/screens/posts.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  posts,
  postComments,
}

final appRoutes = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
        path: '/',
        name: AppRoutes.posts.name,
        builder: (context, state) => const PostsScreen(),
        routes: [
          GoRoute(
            path: 'postComments',
            name: AppRoutes.postComments.name,
            builder: (context, state) {
              final postEntity = state.extra as PostEntity;
              return PostComments(
                postEntity: postEntity,
              );
            },
          ),
        ])
  ],
  errorBuilder: (context, state) => const ErrorScreen404(),
);
