import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/constants/strings.dart';
import 'package:starter_architecture_flutter_firebase/src/features/home/data/firestore_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/home/models/job.dart';
import 'package:starter_architecture_flutter_firebase/src/features/job_entries/job_entries_page.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/edit_job_page.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/job_list_tile.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/list_items_builder.dart';
import 'package:starter_architecture_flutter_firebase/src/utils/alert_dialogs.dart';

// watch database
class JobsPage extends ConsumerWidget {
  Future<void> _delete(BuildContext context, WidgetRef ref, Job job) async {
    try {
      await ref.read(databaseProvider).deleteJob(job);
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: 'Operation failed',
        exception: e,
      ));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.jobs),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => EditJobPage.show(context),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final jobsAsyncValue = ref.watch(jobsStreamProvider);
          return ListItemsBuilder<Job>(
            data: jobsAsyncValue,
            itemBuilder: (context, job) => Dismissible(
              key: Key('job-${job.id}'),
              background: Container(color: Colors.red),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => _delete(context, ref, job),
              child: JobListTile(
                job: job,
                onTap: () => JobEntriesPage.show(context, job),
              ),
            ),
          );
        },
      ),
    );
  }
}
