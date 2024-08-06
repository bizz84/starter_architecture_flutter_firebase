import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';

class SecondaryActionButton extends ConsumerWidget {
  final Function onTap;
  final bool isDisabled;
  final String buttonText;
  const SecondaryActionButton({super.key, required this.buttonText, required this.onTap, this.isDisabled = false});
  @override
  Widget build(BuildContext context, WidgetRef ref) => InkWell(
      onTap: () => onTap(),
      child: Center(
          child: Text(buttonText, style: TextStyle(color: CustomColors().primaryTextColor).copyWith(height: 5))));
}
