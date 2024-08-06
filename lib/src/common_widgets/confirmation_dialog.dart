part of 'package:flutter_starter_base_app/src/utils/alert_dialogs.dart';

Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  bool? useRootNavigator,
  required String defaultActionText,
}) async {
  return showDialog(
    context: context,
    useRootNavigator: useRootNavigator ?? false,
    builder: (context) => AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      title: Text(title, maxLines: content != null ? 1 : 3),
      content: content != null ? Text(content, maxLines: 3) : null,
      actions: <Widget>[
        if (cancelActionText != null) TextButton(child: Text(cancelActionText), onPressed: () => context.pop(false)),
        TextButton(child: Text(defaultActionText), onPressed: () => context.pop(true)),
      ],
    ),
  );
}
