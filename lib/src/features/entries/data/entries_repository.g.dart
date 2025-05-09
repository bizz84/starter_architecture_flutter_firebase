// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entries_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(entriesRepository)
const entriesRepositoryProvider = EntriesRepositoryProvider._();

final class EntriesRepositoryProvider
    extends $FunctionalProvider<EntriesRepository, EntriesRepository>
    with $Provider<EntriesRepository> {
  const EntriesRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'entriesRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$entriesRepositoryHash();

  @$internal
  @override
  $ProviderElement<EntriesRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EntriesRepository create(Ref ref) {
    return entriesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EntriesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<EntriesRepository>(value),
    );
  }
}

String _$entriesRepositoryHash() => r'17cd56c685d800f8456e9f526108ae479eb0aec2';

@ProviderFor(jobEntriesQuery)
const jobEntriesQueryProvider = JobEntriesQueryFamily._();

final class JobEntriesQueryProvider
    extends $FunctionalProvider<Query<Entry>, Query<Entry>>
    with $Provider<Query<Entry>> {
  const JobEntriesQueryProvider._(
      {required JobEntriesQueryFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'jobEntriesQueryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$jobEntriesQueryHash();

  @override
  String toString() {
    return r'jobEntriesQueryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Query<Entry>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Query<Entry> create(Ref ref) {
    final argument = this.argument as String;
    return jobEntriesQuery(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Query<Entry> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<Query<Entry>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is JobEntriesQueryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$jobEntriesQueryHash() => r'b6028feba070a55b2cf62b18cb3849cefecd27ab';

final class JobEntriesQueryFamily extends $Family
    with $FunctionalFamilyOverride<Query<Entry>, String> {
  const JobEntriesQueryFamily._()
      : super(
          retry: null,
          name: r'jobEntriesQueryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  JobEntriesQueryProvider call(
    String jobId,
  ) =>
      JobEntriesQueryProvider._(argument: jobId, from: this);

  @override
  String toString() => r'jobEntriesQueryProvider';
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
