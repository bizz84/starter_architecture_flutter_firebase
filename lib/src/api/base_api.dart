import 'package:flutter_starter_base_app/src/root/domain/account.dart';
import 'package:flutter_starter_base_app/src/root/domain/basic_api_response.dart';
import 'package:flutter_starter_base_app/src/root/domain/contact.dart';
import 'package:flutter_starter_base_app/src/root/domain/country_data.dart';
import 'package:flutter_starter_base_app/src/features/account/domain/eula.dart';
import 'package:flutter_starter_base_app/src/features/report/domain/report_data.dart';

mixin BaseAPI {

  Future<List<Contact>> getData();

  Future<void> login({required String username, required String password});

  Future<bool> refreshToken();

  Future<APIResponse> forgotPassword({required String username});

  Future<APIResponse> resetPassword({required String username, required String otp, required String newPassword});

  Future<AccountDetails> getAccountDetails();

  Future<APIResponse> saveAccountDetails({required String phoneNumber, required String emailId});

  Future<List<Country>> getCountries();

  Future<List<State>> getStates({required String countryName});

  Future<bool> acceptedEULA();

  Future<EULA> getEULA(String languageCode);

  Future<List<ReportData>> getReportData(String timeWindow);
}
