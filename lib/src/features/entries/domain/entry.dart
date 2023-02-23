import 'package:equatable/equatable.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/domain/job.dart';

typedef EntryID = String;

class Entry extends Equatable {
  const Entry({
    required this.id,
    required this.jobId,
    required this.start,
    required this.end,
    required this.comment,
  });
  final EntryID id;
  final JobID jobId;
  final DateTime start;
  final DateTime end;
  final String comment;

  @override
  List<Object> get props => [id, jobId, start, end, comment];

  @override
  bool get stringify => true;

  double get durationInHours =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  factory Entry.fromMap(Map<dynamic, dynamic> value, EntryID id) {
    final startMilliseconds = value['start'] as int;
    final endMilliseconds = value['end'] as int;
    return Entry(
      id: id,
      jobId: value['jobId'] as String,
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
      comment: value['comment'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobId': jobId,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'comment': comment,
    };
  }
}
