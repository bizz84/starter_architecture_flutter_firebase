// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_entries_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(JobsEntriesListController)
const jobsEntriesListControllerProvider = JobsEntriesListControllerProvider._();

final class JobsEntriesListControllerProvider
    extends $AsyncNotifierProvider<JobsEntriesListController, void> {
  const JobsEntriesListControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'jobsEntriesListControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$jobsEntriesListControllerHash();

  @$internal
  @override
  JobsEntriesListController create() => JobsEntriesListController();

  @$internal
  @override
  $AsyncNotifierProviderElement<JobsEntriesListController, void> $createElement(
          $ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(pointer);
}

String _$jobsEntriesListControllerHash() =>
    r'f9a08b66a0c962d210a09aebb711d38acb354b1e';

abstract class _$JobsEntriesListController extends $AsyncNotifier<void> {
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
