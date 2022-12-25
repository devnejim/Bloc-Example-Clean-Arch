import 'package:bloc_app_example/core/extensions/build_context_extension.dart';
import 'package:bloc_app_example/core/extensions/string_extension.dart';
import 'package:bloc_app_example/core/extensions/widget_extension.dart';
import 'package:bloc_app_example/features/posts/domain/entities/post.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common_widgets/app_text.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.postEntity});
  final PostEntity postEntity;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        child: Column(
          children: [
            AppText(
              style: context.appTextTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
              text: postEntity.title.capitalizeFirstOfEach,
              textAlign: TextAlign.center,
            ),
            AppText(
              style: context.appTextTheme.bodySmall!,
              textAlign: TextAlign.center,
              text: postEntity.body.capitalizeFirst,
            ),
          ],
        ).paddingSymetric(vertical: 10),
      ),
    );
  }
}
