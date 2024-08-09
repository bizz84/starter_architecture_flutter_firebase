import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_starter_base_app/src/common_widgets/subsection_title.dart';
import 'package:flutter_starter_base_app/src/features/report/domain/report_by.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/features/report/domain/report_frame.dart';
import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:flutter_starter_base_app/src/features/report/data/report_providers.dart';
import 'package:flutter_starter_base_app/src/features/report/presentation/report_subtitle.dart';
import 'package:flutter_starter_base_app/src/features/report/presentation/bar_view_legend.dart';
import 'package:flutter_starter_base_app/src/features/report/presentation/elliptic_button.dart';
import 'package:flutter_starter_base_app/src/features/report/presentation/report_bar_view.dart';
import 'package:flutter_starter_base_app/src/features/report/presentation/time_window_select.dart';

class ReportsPage extends ConsumerWidget {
  const ReportsPage({super.key});

  ///todo change trigger future provider by vehicle list => already returns all the vehicles
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(reportBy);
    ref.watch(triggerPage);
    ref.watch(currentTimeWindow.notifier).stream.listen(
        onDone: () => newReportList = null,
        (TimeWindow? event) => (ref.read(currentlySelectedVehicleList.notifier).state.isEmpty || event == null)
            ? null
            : newReportList = ReportDataProvider(timeWindow: event.timeWindowEum.name));
    ref.watch(currentlySelectedVehicleList.notifier).stream.listen(onDone: () => newReportList = null, (_) {
      TimeWindow? currentTimeWindowLocal = ref.read(currentTimeWindow);
      ref.read(currentlySelectedVehicleList.notifier).state.isEmpty || currentTimeWindowLocal == null
          ? newReportList = null
          : newReportList = ReportDataProvider(timeWindow: currentTimeWindowLocal.timeWindowEum.name);
    });
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
                titleWidget: Text(LocaleKeys.common_reports.tr(),
                    style: DefaultTheme().defaultTextStyle(20).copyWith(fontWeight: FontWeight.w500))),
            body: CustomScrollView(slivers: [
              SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                      color: CustomColors().darkGray,
                      child: Column(children: [
                        Flexible(
                            child: Center(
                                child: Text(LocaleKeys.reports_vehicleEnergyReport.tr(),
                                    style: DefaultTheme().defaultTextStyle(20)))),
                        Flexible(
                            flex: 9,
                            child: Column(children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                      color: CustomColors().lightGrayColor,
                                      child: Column(children: [
                                        TimeWindowSingleSelect(
                                            text: LocaleKeys.reports_tw_title.tr(),
                                            description: 'description',
                                            value: ref.watch(currentTimeWindow.notifier).state.displayText),
                                        const Padding(
                                            padding: EdgeInsets.only(left: 10, right: 10), child: PopupMenuDivider()),
                                        Column(children: [ReportBarView(reportDataProvider: newReportList)]),
                                        ReportSubTitle(text: LocaleKeys.reports_info_barSelection.tr()),
                                        const Row(children: [
                                          Row(children: [
                                            SizedBox(width: 10),
                                            EllipticButton(text: '\$', setReportByTo: ReportBy.cost),
                                            EllipticButton(text: 'KW', mirror: true, setReportByTo: ReportBy.power),
                                          ]),
                                          Spacer(),
                                          BarViewLegend()
                                        ]),
                                        const SizedBox(height: 10)
                                      ]))
                              ),
                            ]))
                      ])))
            ])));
  }
}
