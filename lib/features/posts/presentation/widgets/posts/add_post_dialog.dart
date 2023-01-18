import 'package:flutter/material.dart';

class AddPostDialog extends StatelessWidget {
  const AddPostDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          TextField(decoration: InputDecoration(label: Text('Title'))),
          SizedBox(
            height: 5,
          ),
          TextField(
              decoration: InputDecoration(label: Text('Body')), maxLines: 4),
        ],
      ),
    );
  }
}
