// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(authProviders)
const authProvidersProvider = AuthProvidersProvider._();

final class AuthProvidersProvider extends $FunctionalProvider<
        List<AuthProvider<AuthListener, AuthCredential>>,
        List<AuthProvider<AuthListener, AuthCredential>>>
    with $Provider<List<AuthProvider<AuthListener, AuthCredential>>> {
  const AuthProvidersProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authProvidersProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authProvidersHash();

  @$internal
  @override
  $ProviderElement<List<AuthProvider<AuthListener, AuthCredential>>>
      $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  List<AuthProvider<AuthListener, AuthCredential>> create(Ref ref) {
    return authProviders(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
      List<AuthProvider<AuthListener, AuthCredential>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $ValueProvider<List<AuthProvider<AuthListener, AuthCredential>>>(
              value),
    );
  }
}

String _$authProvidersHash() => r'8a83535c31539dac72f21c3f27b7d7fb77161e5f';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
