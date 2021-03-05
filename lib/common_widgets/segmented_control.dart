import 'package:flutter/cupertino.dart';

class SegmentedControl<T extends Object> extends StatelessWidget {
  const SegmentedControl({
    required this.header,
    required this.value,
    required this.children,
    this.onValueChanged,
  });
  final Widget header;
  final T value;
  final Map<T, Widget> children;
  final ValueChanged<T>? onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: header,
        ),
        SizedBox(
          width: double.infinity,
          child: CupertinoSegmentedControl<T>(
            children: children,
            groupValue: value,
            onValueChanged: onValueChanged,
          ),
        ),
      ],
    );
  }
}
