// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_screen_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(EntryScreenController)
const entryScreenControllerProvider = EntryScreenControllerProvider._();

final class EntryScreenControllerProvider
    extends $AsyncNotifierProvider<EntryScreenController, void> {
  const EntryScreenControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'entryScreenControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$entryScreenControllerHash();

  @$internal
  @override
  EntryScreenController create() => EntryScreenController();

  @$internal
  @override
  $AsyncNotifierProviderElement<EntryScreenController, void> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(pointer);
}

String _$entryScreenControllerHash() =>
    r'75638e7eac6bacd498349a143fc5fc827171674a';

abstract class _$EntryScreenController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<void>>, AsyncValue<void>, Object?, Object?>;
    element.handleValue(ref, null);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
