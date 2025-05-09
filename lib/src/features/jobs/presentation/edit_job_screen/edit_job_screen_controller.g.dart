// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_job_screen_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(EditJobScreenController)
const editJobScreenControllerProvider = EditJobScreenControllerProvider._();

final class EditJobScreenControllerProvider
    extends $AsyncNotifierProvider<EditJobScreenController, void> {
  const EditJobScreenControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'editJobScreenControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$editJobScreenControllerHash();

  @$internal
  @override
  EditJobScreenController create() => EditJobScreenController();

  @$internal
  @override
  $AsyncNotifierProviderElement<EditJobScreenController, void> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(pointer);
}

String _$editJobScreenControllerHash() =>
    r'e2985913f443860f6aa9d1b0aa462d4e5c25bed4';

abstract class _$EditJobScreenController extends $AsyncNotifier<void> {
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
