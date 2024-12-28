import 'package:flutter/material.dart';

Future<void> showLoadingDialog(BuildContext context, Future futureTask) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      futureTask.then(
        (value) {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
      );
      return const Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}
