import 'package:flutter_starter_base_app/src/constants/env_constants.dart';

class APIEndpoint {
  static const apiPath = "${EnvValues.apiEnv}/${EnvValues.apiVersion}";

  // Example API Endpoint Path
  static const String data = '$apiPath/data';

  /// Account
  static const String auth = '$apiPath/auth/login';
  static const String refreshToken = '$apiPath/auth/refresh-token';
  static const String forgotPassword = '$apiPath/auth/forgot-password';
  static const String resetPassword = '$apiPath/auth/reset-password';
  static const String accountDetails = '$apiPath/accounts/details';
  static const String accountEULAStatus = '$apiPath/user-agreement/status';
  static const String accountEULASubmit = '$apiPath/user-agreement/submit';
  static String accountLatestEULA(String languageCode) => '$apiPath/user-agreement/latest?languageCode=$languageCode';
  static const String createAccount = '$apiPath/auth/create-account';

  /// Country
  static const String countries = '$apiPath/countries';

  /// States
  static String states(String country) => '$apiPath/states?country=$country';

  /// Schedule
  static String scheduleDetails(String chargerId) => '$apiPath/schedules/details?chargerId=$chargerId';

  /// Reports
  /// Add project specific reporting API
  static String getReportData(String duration) => '$apiPath/reports?duration=$duration';

  ///
  static String infoText(String languageCode) => '$apiPath/information-text?languageCode=$languageCode';

  /// Call with --dart-define-from-file=.env/dev.json
  Future<String> buildBase() async {
    String? apiHost;

    if (EnvValues.env == EnvValues.preProductionEnv) {
      apiHost = EnvValues.apiHost;
    }
    if (apiHost == null || apiHost.isEmpty) {
      throw Exception('Cannot build API Endpoint');
    }
    return "$apiHost/";
  }
}
