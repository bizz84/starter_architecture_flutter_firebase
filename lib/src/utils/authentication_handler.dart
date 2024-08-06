import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter_starter_base_app/src/api/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationHandler {
  final _usernameKey = 'username';
  final _accessTokenKey = 'access_token';
  final _refreshTokenKey = 'refresh_token';
  final _storage = const FlutterSecureStorage();
  Future<void> clearTokens() async => await _storage.deleteAll();
  Future<String?> getUsername() async => await _storage.read(key: _usernameKey);
  Future<String?> getAccessToken() async => await _storage.read(key: _accessTokenKey);
  Future<String?> getRefreshToken() async => await _storage.read(key: _refreshTokenKey);
  Future<void> saveUsername(String username) async => await _storage.write(key: _usernameKey, value: username);
  Future<void> saveTokens(String accessToken, String refreshToken) async => await _storage
      .write(key: _accessTokenKey, value: accessToken)
      .then((_) async => await _storage.write(key: _refreshTokenKey, value: refreshToken));
  Future<bool> isTokenExpired() async {
    String? tokenOrNull = await getAccessToken();
    if (tokenOrNull == null || tokenOrNull.isEmpty) return true;
    DateTime? expiryDateOrNull = Jwt.getExpiryDate(tokenOrNull);
    if (expiryDateOrNull == null) return true;
    return DateTime.now().toUtc().isAfter(expiryDateOrNull);
  }

  Future<bool> canAuthenticateUser() async => await isTokenExpired()
      ? (await getUsername()) == null || (await getRefreshToken() == null)
          ? false
          : await API().refreshToken()
      : true;
}
