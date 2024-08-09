import 'package:flutter_starter_base_app/src/api/api_facade.dart';
import 'package:flutter_starter_base_app/src/common_widgets/bluetooth_scanner/domain/bluetooth_response.dart';
import 'package:flutter_starter_base_app/src/root/domain/country_data.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'providers.g.dart';

@riverpod
Future<List<State>> fetchStateList(FetchStateListRef ref, {required String countryName}) async =>
    (await APIFacade().getApi()).getStates(countryName: countryName);