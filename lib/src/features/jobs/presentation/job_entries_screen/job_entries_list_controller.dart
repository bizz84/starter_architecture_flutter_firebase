import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/entries/data/entries_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/domain/entry.dart';

class JobsEntriesListController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> deleteEntry(EntryID entryId) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(entriesRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => repository.deleteEntry(uid: currentUser.uid, entryId: entryId));
  }
}

final jobsEntriesListControllerProvider =
    AutoDisposeAsyncNotifierProvider<JobsEntriesListController, void>(
        JobsEntriesListController.new);
