import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/features/report/presentation/report_subtitle.dart';

class BarViewLegend extends StatelessWidget {
  const BarViewLegend({super.key});

  @override
  Widget build(BuildContext context) => Row(children: [
        Row(children: [
          Container(height: 10, width: 10, color: CustomColors().reportBarBlue),
           ReportSubTitle(text:LocaleKeys.reports_bar_legendHome.tr())
        ]),
        Row(children: [
          Container(height: 10, width: 10, color: CustomColors().reportBarGray),
           ReportSubTitle(text: LocaleKeys.reports_bar_legendpub.tr())
        ])
      ]);
}
