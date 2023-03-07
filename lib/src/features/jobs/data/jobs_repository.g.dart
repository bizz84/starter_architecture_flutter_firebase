// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jobsRepositoryHash() => r'99834710b25b2229bf6bd85bb1e522bfb2b61d5b';

/// See also [jobsRepository].
@ProviderFor(jobsRepository)
final jobsRepositoryProvider = Provider<JobsRepository>.internal(
  jobsRepository,
  name: r'jobsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$jobsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef JobsRepositoryRef = ProviderRef<JobsRepository>;
String _$jobsQueryHash() => r'46482866aecb8be7e41fd6bdb0e2d5a6a87fc350';

/// See also [jobsQuery].
@ProviderFor(jobsQuery)
final jobsQueryProvider = AutoDisposeProvider<Query<Job>>.internal(
  jobsQuery,
  name: r'jobsQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$jobsQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef JobsQueryRef = AutoDisposeProviderRef<Query<Job>>;
String _$jobStreamHash() => r'72fc86cf080cd4a6bdb2da9f13ff81efb312521e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef JobStreamRef = AutoDisposeStreamProviderRef<Job>;

/// See also [jobStream].
@ProviderFor(jobStream)
const jobStreamProvider = JobStreamFamily();

/// See also [jobStream].
class JobStreamFamily extends Family<AsyncValue<Job>> {
  /// See also [jobStream].
  const JobStreamFamily();

  /// See also [jobStream].
  JobStreamProvider call(
    String jobId,
  ) {
    return JobStreamProvider(
      jobId,
    );
  }

  @override
  JobStreamProvider getProviderOverride(
    covariant JobStreamProvider provider,
  ) {
    return call(
      provider.jobId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'jobStreamProvider';
}

/// See also [jobStream].
class JobStreamProvider extends AutoDisposeStreamProvider<Job> {
  /// See also [jobStream].
  JobStreamProvider(
    this.jobId,
  ) : super.internal(
          (ref) => jobStream(
            ref,
            jobId,
          ),
          from: jobStreamProvider,
          name: r'jobStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$jobStreamHash,
          dependencies: JobStreamFamily._dependencies,
          allTransitiveDependencies: JobStreamFamily._allTransitiveDependencies,
        );

  final String jobId;

  @override
  bool operator ==(Object other) {
    return other is JobStreamProvider && other.jobId == jobId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, jobId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
