import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/constants/svg_loader.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';

class PasswordInputField extends ConsumerWidget {
  final String mainText;
  final String hintText;

  final AutoDisposeStateProvider<String> password;

  const PasswordInputField({super.key, required this.password, required this.hintText, required this.mainText});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Container(
          color: CustomColors().darkGrayBG,
          padding: const EdgeInsets.only(left: 17, right: 17),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Row(children: [
                  Text(mainText, style: DanlawTheme().defaultTextStyle(18)),
                  Tooltip(
                      message: 'description',
                      child: Container(padding: const EdgeInsets.only(left: 10), child: SVGLoader().questionMark))
                ])),
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: TextField(
                    autofocus: true,
                    obscureText: true,
                    obscuringCharacter: "*",
                    cursorColor: CustomColors().primaryTextColor,
                    onChanged: (newPassword) => ref.watch(password.notifier).update((state) => newPassword),
                    style: DanlawTheme().defaultTextStyle(15).copyWith(color: CustomColors().primaryTextColor),
                    decoration: InputDecoration(
                        filled: true,
                        hintText: hintText,
                        border: InputBorder.none,
                        fillColor: Colors.transparent,
                        hintTextDirection: TextDirection.rtl,
                        hintStyle:
                            DanlawTheme().defaultTextStyle(15).copyWith(color: CustomColors().primaryTextColor))))
          ])));
}
