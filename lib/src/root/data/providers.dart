import 'package:flutter_starter_base_app/src/root/domain/contact.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_starter_base_app/src/api/api.dart';
part 'providers.g.dart';

@riverpod
Future<List<Contact>> getData(GetDataRef ref) async {
  return await API().getData();
}



