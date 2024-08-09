import 'package:flutter/material.dart';
import 'package:flutter_starter_base_app/src/common_widgets/app_bar.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/common_widgets/circular_loading_animation.dart';
import 'package:flutter_starter_base_app/src/features/report/data/report_providers.dart';
import 'package:flutter_starter_base_app/src/features/report/domain/report_data.dart';
import 'package:flutter_starter_base_app/src/features/report/presentation/vehicle_report_table.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportTablePage extends ConsumerWidget {
  const ReportTablePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => SafeArea(
      child: Scaffold(
          appBar:
              CustomAppBar(showBackButton: true, titleWidget: Text('Trips', style: DefaultTheme().defaultTextStyle(20))),
          body: ref
              .watch(ReportDataProvider(timeWindow: ref.watch(currentTimeWindow.notifier).state.timeWindowEum.name))
              .when(
                  loading: () => const LoadingAnimation(),
                  error: (error, stackTrace) {
                    if (context.canPop()) context.pop();
                    WidgetsBinding.instance.addPostFrameCallback((_) =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('$error')))));
                    return Container();
                  },
                  data: (List<ReportData> reportData) => Container(
                      color: CustomColors().darkGray,
                      child: SafeArea(
                          child: Scrollbar(
                              thickness: 0,
                              trackVisibility: false,
                              thumbVisibility: false,
                              child: SingleChildScrollView(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 15, top: 15),
                                    child: Center(
                                        child: Text(ref.read(currentTimeWindow).displayText,
                                            style: DefaultTheme().defaultTextStyle(20)))),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: ReportTable(reportData: reportData))
                              ]))))))));
}
