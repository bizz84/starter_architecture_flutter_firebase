import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_starter_base_app/src/root/domain/basic_api_response.dart';
import 'package:flutter_starter_base_app/src/utils/authentication_handler.dart';
import 'package:flutter_starter_base_app/src/api/api.dart';
part 'providers.g.dart';

@riverpod
Future<void> login(LoginRef ref, {required String username, required String password}) async =>
    await API().login(username: username, password: password);
@riverpod
Future<void> logout(LogoutRef ref) async => await AuthenticationHandler().clearTokens();
@riverpod
Future<bool> refreshToken(RefreshTokenRef ref) async => await API().refreshToken();
@riverpod
Future<APIResponse> forgotPassword(ForgotPasswordRef ref, {required String username}) async =>
    await API().forgotPassword(username: username);
@riverpod
Future<APIResponse> resetPassword(ResetPasswordRef ref,
        {required String username, required String otp, required String newPassword}) async =>
    await API().resetPassword(username: username, otp: otp, newPassword: newPassword);

@riverpod
Future<bool> canAuthenticateUser(CanAuthenticateUserRef ref) async => AuthenticationHandler().canAuthenticateUser();
