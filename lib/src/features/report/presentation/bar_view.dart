import 'package:flutter_starter_base_app/src/features/report/domain/report_data.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_starter_base_app/src/utils/bar_view_calculator.dart';
import 'package:flutter_starter_base_app/src/features/report/domain/report_by.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:flutter_starter_base_app/src/features/report/data/report_providers.dart';
import 'package:flutter_starter_base_app/src/features/report/presentation/bar_background.dart';

//todo handle multiple unknown vehicles?
class BarView extends ConsumerWidget {
  final List<ReportData> reportList;

  const BarView({super.key, required this.reportList});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(triggerPage);
    bool reportByCost = ref.read(reportBy) == ReportBy.cost;

    final barViewCalculator = BarViewCalculator(
        values: reportList
            .map((ReportData reportData) => reportData.x + reportData.y)
            .toList());
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 45, right: 15, bottom: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: barViewCalculator
                              .calculateMarkings()
                              .map((String step) =>
                                  Text(step, style: TextStyle(color: CustomColors().lighterGrayText, fontSize: 14)))
                              .toList()))
                ] +
                reportList.map((ReportData reportData) {
                  double homeTotal = reportData.x;
                  double publicTotal = reportData.y;
                  double total = homeTotal + publicTotal;
                  double flexTot = barViewCalculator.calculateFlexValue(total);
                  double flexHome = total <= 0 ? 0 : flexTot * homeTotal / total;
                  double flexPublic = total <= 0 ? 0 : flexTot * publicTotal / total;
                  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Tooltip(
                        decoration:
                            BoxDecoration(color: CustomColors().whitecolor, borderRadius: BorderRadius.circular(40)),
                        triggerMode: TooltipTriggerMode.tap,
                        richMessage:
                                TextSpan(
                                    text: LocaleKeys.reports_viewTrips.tr(),
                                    style: const TextStyle(color: Colors.black),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => context.pushNamed(AppRoute.reportTable.name, extra: reportData.label)
                                ),
                        child: SizedBox(
                            height: 27,
                            child: Stack(children: [
                              const BarBackgroud(),
                              Row(children: [
                                if (flexHome > 0)
                                  Flexible(
                                      flex: (flexHome * 100).toInt(),
                                      child: Container(color: CustomColors().reportBarBlue)),
                                if (flexPublic > 0)
                                  Flexible(
                                      flex: (flexPublic * 100).toInt(),
                                      child: Container(color: CustomColors().reportBarGray)),
                                Spacer(flex: (((1 - flexTot)) * 100).toInt())
                              ])
                            ]))),
                    const SizedBox(height: 10),
                    Text(reportData.label, style: DanlawTheme().defaultTextStyle(15)),
                    const SizedBox(height: 20)
                  ]);
                }).toList()));
  }
}
