// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entries_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(entriesService)
const entriesServiceProvider = EntriesServiceProvider._();

final class EntriesServiceProvider
    extends $FunctionalProvider<EntriesService, EntriesService>
    with $Provider<EntriesService> {
  const EntriesServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'entriesServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$entriesServiceHash();

  @$internal
  @override
  $ProviderElement<EntriesService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EntriesService create(Ref ref) {
    return entriesService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EntriesService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<EntriesService>(value),
    );
  }
}

String _$entriesServiceHash() => r'106c29e519ac1706956f952263745337399caba9';

@ProviderFor(entriesTileModelStream)
const entriesTileModelStreamProvider = EntriesTileModelStreamProvider._();

final class EntriesTileModelStreamProvider extends $FunctionalProvider<
        AsyncValue<List<EntriesListTileModel>>,
        Stream<List<EntriesListTileModel>>>
    with
        $FutureModifier<List<EntriesListTileModel>>,
        $StreamProvider<List<EntriesListTileModel>> {
  const EntriesTileModelStreamProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'entriesTileModelStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$entriesTileModelStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<EntriesListTileModel>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<EntriesListTileModel>> create(Ref ref) {
    return entriesTileModelStream(ref);
  }
}

String _$entriesTileModelStreamHash() =>
    r'e8f3184f1b1db43eb92198669492a36d3ee03356';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
