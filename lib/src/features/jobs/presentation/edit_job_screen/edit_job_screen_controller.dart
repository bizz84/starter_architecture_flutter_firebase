import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/home/data/firestore_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/home/models/job.dart';

class EditJobScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> submit(Job? job, String name, int ratePerHour) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final database = ref.read(databaseProvider);
    state = AsyncLoading();
    // TODO: use a Future
    final jobs = await database.jobsStream(uid: currentUser.uid).first;
    final allLowerCaseNames =
        jobs.map((job) => job.name.toLowerCase()).toList();
    if (job != null) {
      allLowerCaseNames.remove(job.name.toLowerCase());
    }
    // check if name is already used
    if (allLowerCaseNames.contains(name.toLowerCase())) {
      // TODO: Define error
      state = AsyncError(Exception('Name already used'), StackTrace.current);
      // await showAlertDialog(
      //   context: context,
      //   title: 'Name already used',
      //   content: 'Please choose a different job name',
      //   defaultActionText: 'OK',
      // );
    } else {
      final id = job?.id ?? documentIdFromCurrentDate();
      final updated = Job(id: id, name: name, ratePerHour: ratePerHour);
      state = await AsyncValue.guard(
        () => database.setJob(uid: currentUser.uid, job: updated),
      );
      //Navigator.of(context).pop();
    }
  }
}

final editJobScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<EditJobScreenController, void>(
        EditJobScreenController.new);
