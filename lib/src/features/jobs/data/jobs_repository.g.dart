// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(jobsRepository)
const jobsRepositoryProvider = JobsRepositoryProvider._();

final class JobsRepositoryProvider
    extends $FunctionalProvider<JobsRepository, JobsRepository>
    with $Provider<JobsRepository> {
  const JobsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'jobsRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$jobsRepositoryHash();

  @$internal
  @override
  $ProviderElement<JobsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  JobsRepository create(Ref ref) {
    return jobsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JobsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<JobsRepository>(value),
    );
  }
}

String _$jobsRepositoryHash() => r'38b37bbcb0ced4ca0754f549ebbe9384bc2bda31';

@ProviderFor(jobsQuery)
const jobsQueryProvider = JobsQueryProvider._();

final class JobsQueryProvider
    extends $FunctionalProvider<Query<Job>, Query<Job>>
    with $Provider<Query<Job>> {
  const JobsQueryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'jobsQueryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$jobsQueryHash();

  @$internal
  @override
  $ProviderElement<Query<Job>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Query<Job> create(Ref ref) {
    return jobsQuery(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Query<Job> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<Query<Job>>(value),
    );
  }
}

String _$jobsQueryHash() => r'aeaccb50f75b9e5bc97b07443935ffd432dba51a';

@ProviderFor(jobStream)
const jobStreamProvider = JobStreamFamily._();

final class JobStreamProvider
    extends $FunctionalProvider<AsyncValue<Job>, Stream<Job>>
    with $FutureModifier<Job>, $StreamProvider<Job> {
  const JobStreamProvider._(
      {required JobStreamFamily super.from, required JobID super.argument})
      : super(
          retry: null,
          name: r'jobStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$jobStreamHash();

  @override
  String toString() {
    return r'jobStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Job> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Job> create(Ref ref) {
    final argument = this.argument as JobID;
    return jobStream(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is JobStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$jobStreamHash() => r'0713110998fd87210993baf69e4d9cf722a73031';

final class JobStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Job>, JobID> {
  const JobStreamFamily._()
      : super(
          retry: null,
          name: r'jobStreamProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  JobStreamProvider call(
    JobID jobId,
  ) =>
      JobStreamProvider._(argument: jobId, from: this);

  @override
  String toString() => r'jobStreamProvider';
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
