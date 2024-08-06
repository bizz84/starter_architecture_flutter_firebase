import 'package:flutter/widgets.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/constants/theme_data.dart';

class SubSectionTitle extends StatelessWidget {
  final String text;

  const SubSectionTitle({super.key, required this.text});
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 5),
      child: Text(text, style: DanlawTheme().defaultTextStyle(12).copyWith(color: CustomColors().lightGrayText)));
}
