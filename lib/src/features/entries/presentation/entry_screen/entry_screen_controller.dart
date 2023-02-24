import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/entries/data/entries_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/domain/entry.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/domain/job.dart';

class EntryScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<bool> submit({
    EntryID? entryId,
    required JobID jobId,
    required DateTime start,
    required DateTime end,
    required String comment,
  }) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(entriesRepositoryProvider);
    state = const AsyncLoading();
    if (entryId == null) {
      state = await AsyncValue.guard(() => repository.addEntry(
            uid: currentUser.uid,
            jobId: jobId,
            start: start,
            end: end,
            comment: comment,
          ));
    } else {
      final entry = Entry(
        id: entryId,
        jobId: jobId,
        start: start,
        end: end,
        comment: comment,
      );
      state = await AsyncValue.guard(
          () => repository.updateEntry(uid: currentUser.uid, entry: entry));
    }
    return state.hasError == false;
  }
}

final entryScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<EntryScreenController, void>(
        EntryScreenController.new);
