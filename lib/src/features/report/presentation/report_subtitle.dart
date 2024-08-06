import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter/material.dart';

class ReportSubTitle extends StatelessWidget {
  final String text;
  const ReportSubTitle({super.key, required this.text});
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(10),
      child: Row(children: [Text(text, style: TextStyle(color: CustomColors().lighterGrayText, fontSize: 11))]));
}
