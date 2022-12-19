import 'package:bloc_app_example/core/common_widgets/loading_indicator.dart';
import 'package:bloc_app_example/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:bloc_app_example/features/posts/presentation/widgets/posts/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/error_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Posts Screen'),
        centerTitle: true,
      ),
      body: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state is ErrorState) {
          return AppErrorWidget(
            errorMessage: state.errorMessage,
          );
        } else if (state is DoneState) {
          return PostsList(posts: state.posts);
        } else {
          return const LoadingIndicator();
        }
      }),
    );
  }
}
