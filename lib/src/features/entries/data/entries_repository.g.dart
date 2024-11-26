// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entries_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$entriesRepositoryHash() => r'17cd56c685d800f8456e9f526108ae479eb0aec2';

/// See also [entriesRepository].
@ProviderFor(entriesRepository)
final entriesRepositoryProvider =
    AutoDisposeProvider<EntriesRepository>.internal(
  entriesRepository,
  name: r'entriesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$entriesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EntriesRepositoryRef = AutoDisposeProviderRef<EntriesRepository>;
String _$jobEntriesQueryHash() => r'b6028feba070a55b2cf62b18cb3849cefecd27ab';

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

/// See also [jobEntriesQuery].
@ProviderFor(jobEntriesQuery)
const jobEntriesQueryProvider = JobEntriesQueryFamily();

/// See also [jobEntriesQuery].
class JobEntriesQueryFamily extends Family<Query<Entry>> {
  /// See also [jobEntriesQuery].
  const JobEntriesQueryFamily();

  /// See also [jobEntriesQuery].
  JobEntriesQueryProvider call(
    String jobId,
  ) {
    return JobEntriesQueryProvider(
      jobId,
    );
  }

  @override
  JobEntriesQueryProvider getProviderOverride(
    covariant JobEntriesQueryProvider provider,
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
  String? get name => r'jobEntriesQueryProvider';
}

/// See also [jobEntriesQuery].
class JobEntriesQueryProvider extends AutoDisposeProvider<Query<Entry>> {
  /// See also [jobEntriesQuery].
  JobEntriesQueryProvider(
    String jobId,
  ) : this._internal(
          (ref) => jobEntriesQuery(
            ref as JobEntriesQueryRef,
            jobId,
          ),
          from: jobEntriesQueryProvider,
          name: r'jobEntriesQueryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$jobEntriesQueryHash,
          dependencies: JobEntriesQueryFamily._dependencies,
          allTransitiveDependencies:
              JobEntriesQueryFamily._allTransitiveDependencies,
          jobId: jobId,
        );

  JobEntriesQueryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.jobId,
  }) : super.internal();

  final String jobId;

  @override
  Override overrideWith(
    Query<Entry> Function(JobEntriesQueryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JobEntriesQueryProvider._internal(
        (ref) => create(ref as JobEntriesQueryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        jobId: jobId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Query<Entry>> createElement() {
    return _JobEntriesQueryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JobEntriesQueryProvider && other.jobId == jobId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, jobId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin JobEntriesQueryRef on AutoDisposeProviderRef<Query<Entry>> {
  /// The parameter `jobId` of this provider.
  String get jobId;
}

class _JobEntriesQueryProviderElement
    extends AutoDisposeProviderElement<Query<Entry>> with JobEntriesQueryRef {
  _JobEntriesQueryProviderElement(super.provider);

  @override
  String get jobId => (origin as JobEntriesQueryProvider).jobId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
