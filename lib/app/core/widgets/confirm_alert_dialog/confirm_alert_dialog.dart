import 'package:flutter/material.dart';

class ConfirmAlertDialog extends StatelessWidget {
  final String title;
  final String message;

  const ConfirmAlertDialog({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("CANCEL"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("ACCEPT"),
        ),
      ],
    );
  }
}
