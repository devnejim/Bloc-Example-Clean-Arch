import 'package:bloc_app_example/core/common_widgets/app_text.dart';
import 'package:bloc_app_example/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class ErrorScreen404 extends StatelessWidget {
  const ErrorScreen404({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppText(
            style: context.appTextTheme.titleLarge!,
            text: '404 Page Not Found '),
      ),
    );
  }
}
