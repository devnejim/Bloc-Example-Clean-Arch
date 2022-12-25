import 'package:bloc_app_example/core/common_widgets/app_text.dart';
import 'package:bloc_app_example/core/common_widgets/error_widget.dart';
import 'package:bloc_app_example/core/common_widgets/loading_indicator.dart';
import 'package:bloc_app_example/core/extensions/build_context_extension.dart';
import 'package:bloc_app_example/core/extensions/string_extension.dart';
import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:bloc_app_example/features/posts/presentation/blocs/comments/comments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependencies_injector.dart' as sl;

class PostComments extends StatelessWidget {
  const PostComments({super.key, required this.postEntity});
  final PostEntity postEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.getIt<CommentsBloc>()
        ..add(GetCommentsEvent(postId: postEntity.id)),
      child: Scaffold(
        appBar: AppBar(
          title: AppText(
            style: context.appTextTheme.titleLarge!,
            text: 'Post Comments',
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CommentsBloc, CommentsState>(
          builder: (context, state) {
            if (state is ErrorState) {
              return const AppErrorWidget();
            } else if (state is DoneState) {
              final comments = state.comments;
              return Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        AppText(
                          style: context.appTextTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                          text: postEntity.title.capitalizeFirstOfEach,
                          textAlign: TextAlign.center,
                        ),
                        AppText(
                          style: context.appTextTheme.bodyMedium!,
                          textAlign: TextAlign.center,
                          text: postEntity.body.capitalizeFirst,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return Card(
                          child: ListTile(
                            title: AppText(
                                style: context.appTextTheme.titleSmall!,
                                text: comment.author.capitalizeFirstOfEach),
                            subtitle: AppText(
                                style: context.appTextTheme.bodySmall!,
                                text: comment.body.capitalizeFirst),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {}
            return const LoadingIndicator();
          },
        ),
      ),
    );
  }
}
