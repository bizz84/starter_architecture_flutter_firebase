import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_base_app/src/api/api_endpoints.dart';

class MockInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path == APIEndpoint.countries) {
      return handler.resolve(Response(
        requestOptions: options,
        statusCode: 200,
        data: await loadData('countries'),
      ));
    }
    if (options.path == APIEndpoint.data) {
      return handler.resolve(Response(
        requestOptions: options,
        statusCode: 200,
        data: await loadData('contacts'),
      ));
    }
    if (options.path == APIEndpoint.accountDetails) {
      return handler.resolve(Response(
        requestOptions: options,
        statusCode: 200,
        data: await loadData('account_details'),
      ));
    }
    if (options.path == APIEndpoint.states(options.uri.queryParameters['country'] ?? '')) {
      return handler.resolve(Response(
        requestOptions: options,
        statusCode: 200,
        data: await loadData('states'),
      ));
    }
    if (options.path == APIEndpoint.states(options.uri.queryParameters['zipcode'] ?? '')) {
      return handler.resolve(Response(
        requestOptions: options,
        statusCode: 200,
        data: await loadData('utility_companies'),
      ));
    }
    if (options.path == APIEndpoint.scheduleDetails(options.uri.queryParameters['chargerId'] ?? '')) {
      return handler.resolve(Response(
        requestOptions: options,
        statusCode: 200,
        data: await loadData('custom_schedule_details'),
      ));
    }
    if (options.path == APIEndpoint.infoText(options.uri.queryParameters['languageCode'] ?? 'en-US')) {
      try {
        return handler.resolve(Response(
          requestOptions: options,
          statusCode: 200,
          data: await loadData(options.uri.queryParameters['languageCode'] ?? 'en-US'),
        ));
      } catch (e) {
        return handler.resolve(Response(requestOptions: options, statusCode: 404, data: 'NOT_FOUND'));
      }
    }
  }

  loadData(String filelName) async => jsonDecode(await rootBundle.loadString('mock/$filelName.json'));
}
