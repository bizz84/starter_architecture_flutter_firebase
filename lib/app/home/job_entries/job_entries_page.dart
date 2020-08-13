import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:starter_architecture_flutter_firebase/app/home/job_entries/entry_list_item.dart';
import 'package:starter_architecture_flutter_firebase/app/home/job_entries/entry_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/jobs/edit_job_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/jobs/list_items_builder.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/entry.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/job.dart';
import 'package:alert_dialogs/alert_dialogs.dart';
import 'package:starter_architecture_flutter_firebase/routing/cupertino_tab_view_router.dart';
import 'package:starter_architecture_flutter_firebase/services/firestore_database.dart';
import 'package:pedantic/pedantic.dart';

class JobEntriesPage extends StatefulWidget {
  const JobEntriesPage({@required this.job});
  final Job job;

  static Future<void> show(BuildContext context, Job job) async {
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.jobEntriesPage,
      arguments: job,
    );
  }

  @override
  _JobEntriesPageState createState() => _JobEntriesPageState();
}

class _JobEntriesPageState extends State<JobEntriesPage> {
  Stream<Job> _jobStream;

  @override
  void initState() {
    super.initState();
    final database = context.read<FirestoreDatabase>();
    _jobStream = database.jobStream(jobId: widget.job.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Job>(
      stream: _jobStream,
      builder: (context, snapshot) {
        context
            .watch<Logger>()
            .d('Job StreamBuilder rebuild: ${snapshot.connectionState}');
        final job = snapshot.data;
        final jobName = job?.name ?? '';
        return Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            title: Text(jobName),
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
      },
    );
  }
}

class JobEntriesContents extends StatefulWidget {
  final Job job;
  const JobEntriesContents({@required this.job});

  @override
  _JobEntriesContentsState createState() => _JobEntriesContentsState();
}

class _JobEntriesContentsState extends State<JobEntriesContents> {
  Stream<List<Entry>> _entriesStream;

  @override
  void initState() {
    super.initState();
    final database = context.read<FirestoreDatabase>();
    _entriesStream = database.entriesStream(job: widget.job);
  }

  Future<void> _deleteEntry(Entry entry) async {
    try {
      final database = context.read<FirestoreDatabase>();
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
  Widget build(BuildContext context) {
    return StreamBuilder<List<Entry>>(
      stream: _entriesStream,
      builder: (context, snapshot) {
        context
            .watch<Logger>()
            .d('JobEntries StreamBuilder rebuild: ${snapshot.connectionState}');
        return ListItemsBuilder<Entry>(
          snapshot: snapshot,
          itemBuilder: (context, entry) {
            return DismissibleEntryListItem(
              dismissibleKey: Key('entry-${entry.id}'),
              entry: entry,
              job: widget.job,
              onDismissed: () => _deleteEntry(entry),
              onTap: () => EntryPage.show(
                context: context,
                job: widget.job,
                entry: entry,
              ),
            );
          },
        );
      },
    );
  }
}
