import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/root/domain/country_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_starter_base_app/src/api/api_facade.dart';

part 'providers.g.dart';


@riverpod
Future<List<Country>> fetchCountryList(FetchCountryListRef ref) async => (await APIFacade().getApi()).getCountries();
