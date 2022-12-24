import 'package:bloc_app_example/core/common_widgets/app_text.dart';
import 'package:bloc_app_example/core/extensions/build_context_extension.dart';
import 'package:bloc_app_example/core/extensions/string_extension.dart';
import 'package:bloc_app_example/core/router/app_router.dart';
import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostTile extends StatelessWidget {
  const PostTile({super.key, required this.post});
  final PostEntity post;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => context.goNamed(AppRoutes.postComments.name, extra: post),
        title: AppText(
          style: context.appTextTheme.titleSmall!,
          text: post.title.capitalizeFirstOfEach,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: AppText(
          padding: const EdgeInsets.symmetric(vertical: 4),
          style: context.appTextTheme.bodySmall!,
          text: post.body.capitalizeFirst,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
