import 'package:bloc_app_example/core/common_widgets/app_text.dart';
import 'package:bloc_app_example/core/extensions/build_context_extension.dart';
import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:flutter/material.dart';

class PostComments extends StatelessWidget {
  const PostComments({super.key, required this.postEntity});
  final PostEntity postEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          style: context.appTextTheme.titleLarge!,
          text: 'Post Comments',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: AppText(
          style: context.appTextTheme.bodyMedium!,
          text: 'Comments Screen',
        ),
      ),
    );
  }
}
