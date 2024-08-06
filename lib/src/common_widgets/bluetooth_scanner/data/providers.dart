import 'package:flutter_starter_base_app/src/common_widgets/bluetooth_scanner/domain/bluetooth_response.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'providers.g.dart';

/// for now testing
@riverpod
Future<BluetoothReponse> chargerBluetoothConnection(ChargerBluetoothConnectionRef ref, {required String data}) async {
  //todo timeout
  await Future.delayed(const Duration(seconds: 4));
  return Future.value(BluetoothReponse(message: 'Successfully connected', status: 'Success'));
  // return Future.error(BluetoothReponse(message: 'Failed to connect', status: 'Failed'));
}


class ScanResultState extends StateNotifier<List<ScanResult>> {
  ScanResultState() : super(List<ScanResult>.empty(growable: true));
  List<ScanResult> items() => state;
  clear() => state.clear();
  static final provider = StateNotifierProvider.autoDispose<ScanResultState, List<ScanResult>>((_) => ScanResultState());
  void addIfNotPresent(ScanResult scanResult) => state.contains(scanResult) ? null : state.add(scanResult);
}

/// Keeps track of the selected BT device at Add Charger Flow
final AutoDisposeStateProvider<ScanResult?> currentBluetoothScanResult = StateProvider.autoDispose<ScanResult?>((_) => null);

/// Keeps track of the selected wifi at Add Charger Flow
final AutoDisposeStateProvider<WiFiAccessPoint?> currentWiFiScanResult = StateProvider.autoDispose<WiFiAccessPoint?>((_) => null);

final AutoDisposeStateProvider<String> password = StateProvider.autoDispose<String>((_) => '');

@riverpod

/// todo handle other cases
Future<List<WiFiAccessPoint>> wifiScanResultList(WifiScanResultListRef ref) async =>
    switch (await WiFiScan.instance.canGetScannedResults()) {
      CanGetScannedResults.yes => WiFiScan.instance.getScannedResults(),
      _ => throw Exception('Failed to scan WiFi networks')
    };

