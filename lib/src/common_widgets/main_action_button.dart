import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';

class MainActionButton extends ConsumerWidget {
  final Function onTap;
  final bool isDisabled;
  final String buttonText;
  const MainActionButton({required this.buttonText, required this.onTap, this.isDisabled = false});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () => isDisabled ? null : onTap(),
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith(
                  (states) => isDisabled ? CustomColors().darkGrayBG : CustomColors().primaryTextColor)),
          child: Text(buttonText,
              style: TextStyle(
                  color: isDisabled ? CustomColors().lighterGrayText : CustomColors().secondaryButtonTextColor))));
}
