import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, this.errorMessage});
  final String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMessage ?? 'Something Went Wrong'),
    );
  }
}
