import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:starter_architecture_flutter_firebase/src/features/home/data/firestore_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/home/models/entry.dart';
import 'package:starter_architecture_flutter_firebase/src/features/home/models/job.dart';
import 'package:starter_architecture_flutter_firebase/src/features/job_entries/entry_list_item.dart';
import 'package:starter_architecture_flutter_firebase/src/common_widgets/list_items_builder.dart';
import 'package:starter_architecture_flutter_firebase/src/routing/app_router.dart';
import 'package:starter_architecture_flutter_firebase/src/utils/alert_dialogs.dart';

import '../authentication/data/firebase_auth_repository.dart';

class JobEntriesPage extends ConsumerWidget {
  const JobEntriesPage({required this.jobId, this.job});
  final JobID jobId;
  final Job? job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (job != null) {
      return JobEntriesPageContents(job: job!);
    } else {
      final jobAsync = ref.watch(jobStreamProvider(jobId));
      return jobAsync.when(
        error: (e, st) => Scaffold(
          appBar: AppBar(
            title: Text('Error'),
          ),
          body: Center(child: Text(e.toString())),
        ),
        loading: () => Scaffold(
          appBar: AppBar(
            title: Text('Loading'),
          ),
          body: Center(child: CircularProgressIndicator()),
        ),
        data: (job) => JobEntriesPageContents(job: job),
      );
    }
  }
}

class JobEntriesPageContents extends StatelessWidget {
  const JobEntriesPageContents({super.key, required this.job});
  final Job job;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: JobEntriesAppBarTitle(job: job),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            // EditJobPage
            onPressed: () => context.goNamed(
              AppRoute.editJob.name,
              params: {'id': job.id},
              extra: job,
            ),
          ),
        ],
      ),
      body: JobEntriesList(job: job),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        // EntryPage
        onPressed: () => context.goNamed(
          AppRoute.addEntry.name,
          params: {'id': job.id},
          extra: job,
        ),
      ),
    );
  }
}

class JobEntriesAppBarTitle extends ConsumerWidget {
  const JobEntriesAppBarTitle({required this.job});
  final Job job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsyncValue = ref.watch(jobStreamProvider(job.id));
    return jobAsyncValue.when(
      data: (job) => Text(job.name),
      loading: () => Container(),
      error: (_, __) => Container(),
    );
  }
}

class JobEntriesList extends ConsumerWidget {
  final Job job;
  const JobEntriesList({required this.job});

  Future<void> _deleteEntry(
      BuildContext context, WidgetRef ref, Entry entry) async {
    try {
      final currentUser = ref.read(authRepositoryProvider).currentUser!;
      final database = ref.read(databaseProvider);
      await database.deleteEntry(uid: currentUser.uid, entry: entry);
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
    final entriesStream = ref.watch(jobEntriesStreamProvider(job));
    return ListItemsBuilder<Entry>(
      data: entriesStream,
      itemBuilder: (context, entry) {
        return DismissibleEntryListItem(
          dismissibleKey: Key('entry-${entry.id}'),
          entry: entry,
          job: job,
          onDismissed: () => _deleteEntry(context, ref, entry),
          onTap: () => context.go(
            '/jobs/${job.id}/entries/${entry.id}',
            // AppRoute.entry.name,
            // params: {'id': job.id, 'eid': entry.id},
            extra: entry,
          ),
          // onTap: () => context.goNamed(
          //   AppRoute.entry.name,
          //   params: {'id': job.id, 'eid': entry.id},
          //   extra: entry,
          // ),
        );
      },
    );
  }
}
