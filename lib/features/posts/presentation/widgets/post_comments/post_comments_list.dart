import 'package:bloc_app_example/core/extensions/build_context_extension.dart';
import 'package:bloc_app_example/core/extensions/string_extension.dart';
import 'package:bloc_app_example/features/posts/domain/entities/post_comment.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common_widgets/app_text.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key, required this.comments});
  final List<PostCommentEntity> comments;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
          style: context.appTextTheme.titleSmall!,
          text: 'Comments',
        ),
        Flexible(
          child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              return Card(
                child: ListTile(
                  leading: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 50,
                      minWidth: 50,
                    ),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 15,
                          child: Icon(Icons.person),
                        ),
                        Expanded(
                          child: AppText(
                            textAlign: TextAlign.center,
                            style: context.appTextTheme.bodySmall!,
                            text: comment.author.split(' ')[0].capitalizeFirst,
                          ),
                        )
                      ],
                    ),
                  ),
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
  }
}
