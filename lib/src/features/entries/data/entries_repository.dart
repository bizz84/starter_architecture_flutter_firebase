import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/domain/app_user.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/domain/entry.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/domain/job.dart';

class FirestorePath {
  static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';
  static String jobs(String uid) => 'users/$uid/jobs';
  static String entry(String uid, String entryId) =>
      'users/$uid/entries/$entryId';
  static String entries(String uid) => 'users/$uid/entries';
}

class EntriesRepository {
  const EntriesRepository(this._firestore);
  final FirebaseFirestore _firestore;

  // create
  Future<void> addEntry({
    required UserID uid,
    required JobID jobId,
    required DateTime start,
    required DateTime end,
    required String comment,
  }) =>
      _firestore.collection(FirestorePath.entries(uid)).add({
        'jobId': jobId,
        'start': start.millisecondsSinceEpoch,
        'end': end.millisecondsSinceEpoch,
        'comment': comment,
      });

  // update
  Future<void> updateEntry(
          {required UserID uid,
          required EntryID entryId,
          required Entry entry}) =>
      _firestore.doc(FirestorePath.entry(uid, entryId)).update(entry.toMap());

  // delete
  Future<void> deleteEntry({required UserID uid, required EntryID entryId}) =>
      _firestore.doc(FirestorePath.entry(uid, entryId)).delete();

  // read
  Stream<List<Entry>> watchEntries({required UserID uid, JobID? jobId}) =>
      queryEntries(uid: uid, jobId: jobId)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Query<Entry> queryEntries({required UserID uid, JobID? jobId}) {
    Query<Entry> query =
        _firestore.collection(FirestorePath.entries(uid)).withConverter<Entry>(
              fromFirestore: (snapshot, _) =>
                  Entry.fromMap(snapshot.data()!, snapshot.id),
              toFirestore: (entry, _) => entry.toMap(),
            );
    if (jobId != null) {
      query = query.where('jobId', isEqualTo: jobId);
    }
    return query;
  }
}

final entriesRepositoryProvider = Provider<EntriesRepository>((ref) {
  return EntriesRepository(FirebaseFirestore.instance);
});

final jobEntriesStreamProvider =
    StreamProvider.autoDispose.family<List<Entry>, JobID>((ref, jobId) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user == null) {
    throw AssertionError('User can\'t be null when fetching jobs');
  }
  final repository = ref.watch(entriesRepositoryProvider);
  return repository.watchEntries(uid: user.uid, jobId: jobId);
});
