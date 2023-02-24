import 'package:starter_architecture_flutter_firebase/src/features/entries/domain/entry.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/domain/job.dart';

class EntryJob {
  EntryJob(this.entry, this.job);

  final Entry entry;
  final Job job;
}
