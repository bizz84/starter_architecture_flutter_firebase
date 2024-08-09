import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/constants/svg_loader.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';

class TextInputField extends ConsumerWidget {
  final String mainText;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputFormatter? inputFormatter;
  final AutoDisposeStateProvider<String> textProvider;

  const TextInputField({
    super.key,
    required this.textProvider,
    required this.hintText,
    required this.mainText,
    this.inputFormatter,
    this.validator,
  });
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
                  Text(mainText, style: DefaultTheme().defaultTextStyle(18)),
                  Tooltip(
                      message: 'description',
                      child: Container(padding: const EdgeInsets.only(left: 10), child: SVGLoader().questionMark))
                ])),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: TextFormField(
                    autofocus: true,
                    cursorColor: CustomColors().primaryTextColor,
                    onChanged: (newPassword) => ref.watch(textProvider.notifier).update((state) => newPassword),
                    style: DefaultTheme().defaultTextStyle(15).copyWith(color: CustomColors().primaryTextColor),
                    validator: validator,
                    inputFormatters: inputFormatter == null ? [] : [inputFormatter!],
                    decoration: InputDecoration(
                        filled: true,
                        hintText: hintText,
                        border: InputBorder.none,
                        fillColor: Colors.transparent,
                        hintTextDirection: TextDirection.rtl,
                        hintStyle:
                            DefaultTheme().defaultTextStyle(15).copyWith(color: CustomColors().primaryTextColor))))
          ])));
}
