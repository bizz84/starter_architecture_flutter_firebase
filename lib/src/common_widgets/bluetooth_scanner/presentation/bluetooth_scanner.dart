import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_starter_base_app/src/common_widgets/bluetooth_scanner/data/providers.dart';
import 'package:flutter_starter_base_app/src/common_widgets/reception_icon.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/constants/svg_loader.dart';
import 'package:flutter_starter_base_app/src/constants/theme_data.dart';

class BluetoothHandler extends ConsumerStatefulWidget {
  final AutoDisposeStateProvider<ScanResult?> scanResultProvider;
  const BluetoothHandler({super.key, required this.scanResultProvider});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BluetoothHandlerState();
}

class _BluetoothHandlerState extends ConsumerState<BluetoothHandler> {
  startScan() async {
    ref.read(ScanResultState.provider.notifier).clear();
    setState(() {});
    FlutterBluePlus.setLogLevel(LogLevel.error, color: true);
    StreamSubscription<List<ScanResult>> subscription = FlutterBluePlus.onScanResults.listen((results) {
      if (results.isNotEmpty && results.last.device.advName.isNotEmpty) {
        ref.read(ScanResultState.provider.notifier).addIfNotPresent(results.last);
        setState(() {});
      }
    });
    FlutterBluePlus.cancelWhenScanComplete(subscription);
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
  }

  @override
  void initState() {
    startScan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Expanded(
      child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  color: CustomColors().darkGrayBG,
                  child: Column(
                      children: (ref.watch(ScanResultState.provider)..sort((a, b) => b.rssi - a.rssi))
                          .map((ScanResult scanResult) => Row(children: [
                                InkWell(
                                    onTap: () async => ref.read(widget.scanResultProvider.notifier).state = scanResult,
                                    child: Container(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: ref.watch(widget.scanResultProvider) == scanResult
                                            ? SVGLoader().checkMark
                                            : SVGLoader().emptyMark)),
                                Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.only(left: 10, right: 20),
                                        child: Row(children: [
                                          Text(scanResult.advertisementData.advName,
                                              overflow: TextOverflow.ellipsis,
                                              style: DanlawTheme().defaultTextStyle(18),
                                              softWrap: false,
                                              maxLines: 1),
                                          const Spacer(),
                                          ReceptionIcon(level: scanResult.rssi)
                                        ])))
                              ]))
                          .toList()
                          .asMap()
                          .entries
                          .map((entry) => [
                                if (entry.key != 0)
                                  Container(
                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                      child: const PopupMenuDivider()),
                                entry.value
                              ])
                          .expand((e) => e)
                          .toList())))));
}
