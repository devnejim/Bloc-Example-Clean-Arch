import 'package:bloc_app_example/core/common_widgets/error_widget.dart';
import 'package:bloc_app_example/core/common_widgets/loading_indicator.dart';
import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:bloc_app_example/features/posts/presentation/blocs/comments/comments_bloc.dart';
import 'package:bloc_app_example/features/posts/presentation/widgets/post_comments/post_card.dart';
import 'package:bloc_app_example/features/posts/presentation/widgets/post_comments/post_comments_list.dart';
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
          title: const Text(
            'Post Comments',
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CommentsBloc, CommentsState>(
          builder: (context, state) {
            if (state is ErrorState) {
              return const AppErrorWidget();
            } else if (state is DoneState) {
              final comments = state.comments;
              return RefreshIndicator(
                onRefresh: () async => _onRefresh(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PostCard(postEntity: postEntity),
                    Flexible(child: CommentsList(comments: comments)),
                  ],
                ),
              );
            } else if (state is LoadingState) {
              return const LoadingIndicator();
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    return BlocProvider.of<CommentsBloc>(context)
        .add(RefreshCommentsEvent(postId: postEntity.id));
  }
}










// class PostCommentBody extends StatelessWidget {
//   const PostCommentBody({
//     super.key,
//     required this.onRefresh,
//     required this.postEntity,
//   });

//   final VoidCallback onRefresh;
//   final PostEntity postEntity;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CommentsBloc, CommentsState>(
//       builder: (context, state) {
//         if (state is ErrorState) {
//           return const AppErrorWidget();
//         } else if (state is DoneState) {
//           final comments = state.comments;
//           return RefreshIndicator(
//             onRefresh: () async => onRefresh,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 PostCard(postEntity: postEntity),
//                 Flexible(child: CommentsList(comments: comments)),
//               ],
//             ),
//           );
//         } else if (state is LoadingState) {
//           return const LoadingIndicator();
//         } else {
//           return const SizedBox.shrink();
//         }
//       },
//     );
//   }
// }