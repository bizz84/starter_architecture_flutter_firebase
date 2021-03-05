import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/home/job_entries/entry_list_item.dart';
import 'package:starter_architecture_flutter_firebase/app/home/job_entries/entry_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/jobs/edit_job_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/jobs/list_items_builder.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/entry.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/job.dart';
import 'package:alert_dialogs/alert_dialogs.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';
import 'package:starter_architecture_flutter_firebase/routing/cupertino_tab_view_router.dart';
import 'package:pedantic/pedantic.dart';

class JobEntriesPage extends StatelessWidget {
  const JobEntriesPage({required this.job});
  final Job job;

  static Future<void> show(BuildContext context, Job job) async {
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.jobEntriesPage,
      arguments: job,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: JobEntriesAppBarTitle(job: job),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () => EditJobPage.show(
              context,
              job: job,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => EntryPage.show(
              context: context,
              job: job,
            ),
          ),
        ],
      ),
      body: JobEntriesContents(job: job),
    );
  }
}

final jobStreamProvider =
    StreamProvider.autoDispose.family<Job, String>((ref, jobId) {
  final database = ref.watch(databaseProvider);
  return database.jobStream(jobId: jobId);
});

class JobEntriesAppBarTitle extends ConsumerWidget {
  const JobEntriesAppBarTitle({required this.job});
  final Job job;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final jobAsyncValue = watch(jobStreamProvider(job.id));
    return jobAsyncValue.when(
      data: (job) => Text(job.name),
      loading: () => Container(),
      error: (_, __) => Container(),
    );
  }
}

final jobEntriesStreamProvider =
    StreamProvider.autoDispose.family<List<Entry>, Job>((ref, job) {
  final database = ref.watch(databaseProvider);
  return database.entriesStream(job: job);
});

class JobEntriesContents extends ConsumerWidget {
  final Job job;
  const JobEntriesContents({required this.job});

  Future<void> _deleteEntry(
      BuildContext context, ScopedReader watch, Entry entry) async {
    try {
      final database = watch(databaseProvider);
      await database.deleteEntry(entry);
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: 'Operation failed',
        exception: e,
      ));
    }
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final entriesStream = watch(jobEntriesStreamProvider(job));
    return ListItemsBuilder<Entry>(
      data: entriesStream,
      itemBuilder: (context, entry) {
        return DismissibleEntryListItem(
          dismissibleKey: Key('entry-${entry.id}'),
          entry: entry,
          job: job,
          onDismissed: () => _deleteEntry(context, watch, entry),
          onTap: () => EntryPage.show(
            context: context,
            job: job,
            entry: entry,
          ),
        );
      },
    );
  }
}
