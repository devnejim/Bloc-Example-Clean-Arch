import 'package:bloc_app_example/core/common_widgets/app_text.dart';
import 'package:bloc_app_example/core/extensions/build_context_extension.dart';
import 'package:bloc_app_example/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetPostsButton extends StatelessWidget {
  const GetPostsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: context.secondaryColor),
      child: AppText(style: context.appTextTheme.bodyLarge!, text: 'Get Posts'),
      onPressed: () => context.read<PostsBloc>().add(const GetPostsEvent()),
    );
  }
}
