class EnvValues {
  static String get productionEnv => 'prod';
  static String get preProductionEnv => 'preprod';
  static String get developmentEnv => 'dev';

  static const String env = String.fromEnvironment('ENV');
  static const String username = String.fromEnvironment('USERNAME');
  static const String password = String.fromEnvironment('PASSWORD');

  static const String apiEnv = String.fromEnvironment('API_ENV');
  static const String apiHost = String.fromEnvironment('API_HOST');
  static const String apiVersion = String.fromEnvironment('API_VERSION');
  static const String apiAccessToken = String.fromEnvironment('API_ACCESS_TOKEN');
  static const String apiRefreshToken = String.fromEnvironment('API_REFRESH_TOKEN');
}

class EnvKeys {
  static String get apiAccessTokenKey => 'API_ACCESS_TOKEN';
  static String get apiRefreshTokenKey => 'API_REFRESH_TOKEN';
}
