import 'package:equatable/equatable.dart';
import 'package:flutter_starter_base_app/src/features/entries/domain/entry.dart';
import 'package:flutter_starter_base_app/src/features/jobs/domain/job.dart';

class EntryJob extends Equatable {
  const EntryJob(this.entry, this.job);

  final Entry entry;
  final Job job;

  @override
  List<Object?> get props => [entry, job];

  @override
  bool? get stringify => true;
}
