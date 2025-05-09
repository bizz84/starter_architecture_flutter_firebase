// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_screen_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(JobsScreenController)
const jobsScreenControllerProvider = JobsScreenControllerProvider._();

final class JobsScreenControllerProvider
    extends $AsyncNotifierProvider<JobsScreenController, void> {
  const JobsScreenControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'jobsScreenControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$jobsScreenControllerHash();

  @$internal
  @override
  JobsScreenController create() => JobsScreenController();

  @$internal
  @override
  $AsyncNotifierProviderElement<JobsScreenController, void> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(pointer);
}

String _$jobsScreenControllerHash() =>
    r'e3a40258404cf512fd12924d8f0a485f75d7d6fb';

abstract class _$JobsScreenController extends $AsyncNotifier<void> {
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
