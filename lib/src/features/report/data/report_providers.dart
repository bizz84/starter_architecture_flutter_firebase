import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/features/report/domain/report_data.dart';
import 'package:flutter_starter_base_app/src/root/domain/item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_starter_base_app/src/api/api_facade.dart';
import 'package:flutter_starter_base_app/src/features/report/domain/report_by.dart';
import 'package:flutter_starter_base_app/src/features/report/domain/report_frame.dart';

part 'report_providers.g.dart';

@riverpod
Future<List<ReportData>> reportData(ReportDataRef ref, {required String timeWindow}) async {
  return await (await APIFacade().getApi()).getReportData(timeWindow);
}


StateProvider<dynamic> triggerPage = StateProvider((ref) => null);
StateProvider<ReportBy> reportBy = StateProvider((ref) => ReportBy.cost);
StateProvider<TimeWindow> currentTimeWindow = StateProvider<TimeWindow>((ref) => TimeWindow.values.first);
ReportDataProvider? newReportList = ReportDataProvider(timeWindow: TimeWindow.values.first.timeWindowEum.name);
StateProvider<List<Item>> currentlySelectedVehicleList = StateProvider<List<Item>>((ref) => []);
