import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/data/jobs_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/domain/job.dart';

class JobsScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> deleteJob(Job job) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(jobsRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => repository.deleteJob(uid: currentUser.uid, jobId: job.id));
  }
}

final jobsScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<JobsScreenController, void>(
        JobsScreenController.new);
