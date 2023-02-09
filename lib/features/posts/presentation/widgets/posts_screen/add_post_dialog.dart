import 'package:flutter/material.dart';

const kConfirmPostDialogKey = Key('confirm_add_post_dialog_key');
const kPopPostDialogKey = Key('pop_add_post_dialog_key');
const kTitleTextFieldKey = Key('title_textfield_key');
const kBodyTextFieldKey = Key('body_textfield_key');

class AddPostDialog extends StatelessWidget {
  const AddPostDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          TextField(
              key: kTitleTextFieldKey,
              decoration: InputDecoration(label: Text('Title'))),
          SizedBox(
            height: 5,
          ),
          TextField(
              key: kBodyTextFieldKey,
              decoration: InputDecoration(label: Text('Body')),
              maxLines: 4),
        ],
      ),
      actions: [
        OutlinedButton(
            key: kPopPostDialogKey,
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        OutlinedButton(
          //TODO: Implement Add Function Instead
          key: kConfirmPostDialogKey,
          onPressed: () => Navigator.pop(context),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
