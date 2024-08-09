import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/features/report/data/report_providers.dart';
import 'package:flutter_starter_base_app/src/features/report/domain/report_data.dart';
import 'package:flutter_starter_base_app/src/features/report/presentation/bar_view.dart';
import 'package:flutter_starter_base_app/src/common_widgets/circular_loading_animation.dart';

class ReportBarView extends ConsumerWidget {
  final ReportDataProvider? reportDataProvider;
  const ReportBarView({super.key, required this.reportDataProvider});
  @override
  Widget build(BuildContext context, WidgetRef ref) => reportDataProvider == null
      ? Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Select Vehicles to start', style: DefaultTheme().defaultTextStyle(17)))
      : ref.watch(reportDataProvider!).when(
          loading: () => const LoadingAnimation(),
          data: (reportData) => reportData.isEmpty
              ? Container()
              : BarView(reportData: reportData),
          error: (error, stackTrace) {
            WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Center(child: Text('${(error as Exception)}')))));
            return Container();
          });
}
