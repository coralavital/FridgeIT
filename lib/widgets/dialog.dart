import 'package:flutter/material.dart';
import 'package:fridge_it/widgets/small_text.dart';

class CustomDialog extends StatelessWidget {
  String title;
  String message;

  CustomDialog(
      {super.key,
      required this.title,
      required this.message,
});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$title'),

      content: SmallText(
              text: message,
              // fieldTitle: title,
            ),
          
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Icon(Icons.close_rounded),
        ),
      ],
      actionsAlignment:  MainAxisAlignment.start,
    );
  }
}
