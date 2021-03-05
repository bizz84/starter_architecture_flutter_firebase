import 'package:equatable/equatable.dart';

class Entry extends Equatable {
  const Entry({
    required this.id,
    required this.jobId,
    required this.start,
    required this.end,
    required this.comment,
  });

  final String id;
  final String jobId;
  final DateTime start;
  final DateTime end;
  final String comment;

  @override
  List<Object> get props => [id, jobId, start, end, comment];

  @override
  bool get stringify => true;

  double get durationInHours =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  factory Entry.fromMap(Map<dynamic, dynamic>? value, String id) {
    if (value == null) {
      throw StateError('missing data for entryId: $id');
    }
    final startMilliseconds = value['start'] as int;
    final endMilliseconds = value['end'] as int;
    return Entry(
      id: id,
      jobId: value['jobId'],
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
      comment: value['comment'] ?? '',
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
