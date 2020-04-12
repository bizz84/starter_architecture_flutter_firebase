import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Querying the environment via [Plattform] throws and exception on Flutter web
// This extension adds a new [isWeb] getter that should be used
// before checking for any of the other environments
extension PlatformWeb on Platform {
  static bool get isWeb {
    try {
      if (Platform.isAndroid ||
          Platform.isIOS ||
          Platform.isWindows ||
          Platform.isFuchsia ||
          Platform.isLinux ||
          Platform.isMacOS) {
        return false;
      }
      return true;
    } catch (e) {
      return true;
    }
  }
}

Future<bool> showAlertDialog({
  @required BuildContext context,
  @required String title,
  @required String content,
  String cancelActionText,
  @required String defaultActionText,
}) async {
  if (PlatformWeb.isWeb || !Platform.isIOS) {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if (cancelActionText != null)
            FlatButton(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          FlatButton(
            child: Text(defaultActionText),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
  return await showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        CupertinoDialogAction(
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}
