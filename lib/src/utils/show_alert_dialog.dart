part of 'alert_dialogs.dart';

Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  required String defaultActionText,
}) async {
  if (kIsWeb || !Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: content != null ? Text(content) : null,
        actions: <Widget>[
          if (cancelActionText != null)
            TextButton(child: Text(cancelActionText), onPressed: () => context.canPop() ? context.pop(false) : null),
          TextButton(child: Text(defaultActionText), onPressed: () => context.canPop() ? context.pop(true) : null),
        ],
      ),
    );
  }
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
              child: Text(cancelActionText), onPressed: () => context.canPop() ? context.pop(false) : null),
        CupertinoDialogAction(
            child: Text(defaultActionText), onPressed: () => context.canPop() ? context.pop(true) : null)
      ],
    ),
  );
}
