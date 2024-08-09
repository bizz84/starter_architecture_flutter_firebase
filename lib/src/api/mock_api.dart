import 'dart:convert';

import 'package:flutter_starter_base_app/src/api/api_endpoints.dart';
import 'package:flutter_starter_base_app/src/api/base_api.dart';
import 'package:flutter_starter_base_app/src/api/dio_interceptor.dart';
import 'package:flutter_starter_base_app/src/root/domain/account.dart';
import 'package:flutter_starter_base_app/src/root/domain/basic_api_response.dart';
import 'package:flutter_starter_base_app/src/root/domain/contact.dart';
import 'package:flutter_starter_base_app/src/root/domain/country_data.dart';
import 'package:flutter_starter_base_app/src/features/account/domain/eula.dart';
import 'package:flutter_starter_base_app/src/features/report/domain/report_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


class APIMock implements BaseAPI {

  final dio = Dio(BaseOptions());

  APIMock() {
    dio.interceptors.add(MockInterceptor());
  }

  @override
  Future<List<Contact>> getData() async {
    List<Contact> data = List.empty(growable: true);
    try {
      var contactsJson = (await dio.get(APIEndpoint.data)).data;
      for (int i = 0; i < contactsJson.length; i++) {
        data.add(Contact.fromJson(contactsJson[i]));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  @override
  Future<void> login({required String username, required String password}) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      // implement test logic
      return;
    } catch (e, stacktrace) {
      if (e is DioException && e.response != null) {
        print('Error response domain in Api: ${e.response?.data}');
        throw e; // rethrow the exception to be caught by the calling method
      }
      debugPrint('Error: $e\nStacktrace: $stacktrace');
      throw Exception('Failed to authenticate user: $e');
    }
  }

  @override
  Future<bool> refreshToken() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      // implement test logic
      return true;
    } catch (e, stacktrace) {
      if (e is DioException && e.response != null) {
        print('Error response domain in Api: ${e.response?.data}');
        throw e; // rethrow the exception to be caught by the calling method
      }
      debugPrint('Error: $e\nStacktrace: $stacktrace');
      throw Exception('Failed to authenticate user: $e');
    }
  }

  @override
  Future<APIResponse> forgotPassword({required String username}) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      // implement test logic
      return APIResponse.success();
    } catch (e, stacktrace) {
      if (e is DioException && e.response != null) {
        print('Error response domain in Api: ${e.response?.data}');
        throw e; // rethrow the exception to be caught by the calling method
      }
      debugPrint('Error: $e\nStacktrace: $stacktrace');
      throw Exception('Failed to authenticate user: $e');
    }
  }

  @override
  Future<APIResponse> resetPassword({required String username, required String otp, required String newPassword}) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      // implement test logic
      return APIResponse.success();
    } catch (e, stacktrace) {
      if (e is DioException && e.response != null) {
        print('Error response domain in Api: ${e.response?.data}');
        throw e; // rethrow the exception to be caught by the calling method
      }
      debugPrint('Error: $e\nStacktrace: $stacktrace');
      throw Exception('Failed to authenticate user: $e');
    }
  }

  @override
  Future<List<Country>> getCountries() async {
    List<Country> countries = List.empty(growable: true);
    try {
      var countriesJson = (await dio.get(APIEndpoint.countries))
          .data['data']['countries'];
      for (int i = 0; i < countriesJson.length; i++) {
        countries.add(Country.fromJson(countriesJson[i]));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return countries;
  }

  @override
  Future<AccountDetails> getAccountDetails() async {
    try {
      return AccountDetails.fromJson(
          (await dio.get(APIEndpoint.accountDetails)).data['data']);
    } catch (e) {
      debugPrintStack();
    }
    throw Exception();
  }

  @override
  Future<APIResponse> saveAccountDetails({required String phoneNumber, required String emailId}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      // implement test logic
      return APIResponse.success();
    } catch (e, stacktrace) {
      debugPrint(e.toString() + stacktrace.toString());
    }
    throw Exception('Failed to save Account Details');
  }

  @override
  Future<List<State>> getStates({required String countryName}) async {
    List<State> states = List.empty(growable: true);
    try {
      var statesJson = (await dio.get(APIEndpoint.states(countryName)))
          .data['data']['states'];
      for (int i = 0; i < statesJson.length; i++) {
        states.add(State.fromJson(statesJson[i]));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return states;
  }

  @override
  Future<List<ReportData>> getReportData(String timeWindow) async {
    try {
      List<ReportData> vehicleList = List.empty(growable: true);
      var reportListJson = (await dio.get(
          APIEndpoint.getReportData(timeWindow)))
          .data['data']['vehicles'];
      for (int i = 0; i < reportListJson.length; i++) {
        vehicleList.add(ReportData.fromJson(reportListJson[i]));
      }
      return vehicleList;
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
    }
    throw Exception();
  }

  @override
  Future<bool> acceptedEULA() async {
    await Future.delayed(const Duration(seconds: 3));
    return true;
  }

  Future<EULA> getEULA(String languageCode) async {
    await Future.delayed(const Duration(seconds: 3));
    return EULA.fromJson(
        (await dio.get(APIEndpoint.accountLatestEULA(languageCode)))
            .data['data']);
  }


  Future<dynamic> getInformationText(String languageCode) async {
    try {
      Response response = (await dio.get(APIEndpoint.infoText(languageCode)));
      return response.data['data'];
    } on DioException catch (e) {
      debugPrint(e.message);
      //todo
    } catch (e) {
      //todo
      return null;
    }
    throw Exception();
  }
}

