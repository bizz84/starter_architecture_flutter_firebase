import 'package:flutter_starter_base_app/src/api/api.dart';
import 'package:flutter_starter_base_app/src/api/api_facade.dart';
import 'package:flutter_starter_base_app/src/root/domain/account.dart';
import 'package:flutter_starter_base_app/src/root/domain/basic_api_response.dart';
import 'package:flutter_starter_base_app/src/features/account/domain/create_account.dart';
import 'package:flutter_starter_base_app/src/features/account/domain/eula.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'account_provider.g.dart';

@riverpod
Future<AccountDetails> fetchAccountDetails(FetchAccountDetailsRef ref) async =>
    await (await APIFacade().getApi()).getAccountDetails();

@Riverpod(dependencies: [])
Future<bool> fetchEULAStatus(FetchEULAStatusRef ref) async => await (await APIFacade().getApi()).acceptedEULA();
@Riverpod(dependencies: [])
Future<EULA> fetchEULA(FetchEULARef ref, {required String languageCode}) async => await API().getEULA(languageCode);

@riverpod
Future<bool> submitEULA(SubmitEULARef ref, {required String agreementId}) async => await API().submitEULA(agreementId);

/// tracks EULA ID
StateProvider<EULA?> eulaProvider = StateProvider((ref) => null);

@riverpod
Future<APIResponse> createAccount(CreateAccountRef ref, {required CreateAccountRequest createAccountRequest}) async {
  return await API().createAccount(createAccountRequest: createAccountRequest);
}

@riverpod
Future<APIResponse> saveAccountDetails(SaveAccountDetailsRef ref,{required String phoneNumber, required String emailId}) async{
  return await API().saveAccountDetails(phoneNumber:phoneNumber,emailId:emailId);
}