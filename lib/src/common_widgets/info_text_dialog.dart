part of 'package:flutter_starter_base_app/src/utils/alert_dialogs.dart';

Future<bool?> showInfoDialog(
  BuildContext context, {
  required String label,
  required String content,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      title: Text(label),
      titleTextStyle: DanlawTheme().defaultTextStyle(14),
      content: Text(content, maxLines: 5),
      contentTextStyle: DanlawTheme().defaultTextStyle(14),
      actionsAlignment: MainAxisAlignment.start,
      actions: <Widget>[
        TextButton(child: const Text("OK"), onPressed: () => context.pop()),
      ],
    ),
  );
}


// Usage
// showInfoDialog(context, label: "label", content: "content");