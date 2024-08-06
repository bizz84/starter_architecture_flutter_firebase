import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/features/report/data/report_providers.dart';
import 'package:flutter_starter_base_app/src/features/report/presentation/bar_view.dart';
import 'package:flutter_starter_base_app/src/features/vehicle/domain/report_vehicle.dart';
import 'package:flutter_starter_base_app/src/features/charger/domain/charger_details.dart';
import 'package:flutter_starter_base_app/src/common_widgets/circular_loading_animation.dart';

class ReportBarView extends ConsumerWidget {
  final ReportListProvider? reportList;
  const ReportBarView({super.key, required this.reportList});
  @override
  Widget build(BuildContext context, WidgetRef ref) => reportList == null
      ? Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Select Vehicles to start', style: DanlawTheme().defaultTextStyle(17)))
      : ref.watch(reportList!).when(
          loading: () => const LoadingAnimation(),
          data: (List<ReportVehicle> reportList) => reportList.isEmpty
              ? Container()
              : BarView(
                  reportList: reportList
                      .where((ReportVehicle reportVehicle) => ref
                          .read(currentlySelectedVehicleList)
                          .map((BaseSingleSelect singleSelect) => (singleSelect as LabelValuePair).value)
                          .toList()
                          .contains(reportVehicle.vin))
                      .toList()),
          error: (error, stackTrace) {
            WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Center(child: Text('${(error as Exception)}')))));
            return Container();
          });
}
