import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showExceptionDialog(
    BuildContext context, {
      required Exception exception,
      required String title,
    }) {
  return showAlertDialog(
    context,
    title: title,
    content: _message(exception),
    defaultActionString: 'OK',
  );
}
String? _message(Exception exception){
  if(exception is FirebaseAuthException){return exception.message.toString();}
  else {
    return exception.toString();
  }
}

Future<bool?> showAlertDialog(BuildContext context,
    {required String title,
      required String? content, String? cancelActionText,
      required String defaultActionString}) async {
  if (!Platform.isIOS) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content!),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(defaultActionString)),
            if(cancelActionText != null)
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(cancelActionText)),
          ],
        ));
  }
  return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content!),
        actions: [
          CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(defaultActionString)),
          if(cancelActionText != null)
            CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(cancelActionText)),
        ],
      ));
}