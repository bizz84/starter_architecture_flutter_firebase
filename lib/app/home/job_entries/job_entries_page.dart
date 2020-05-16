import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

class JobEntriesPage extends StatelessWidget {
  const JobEntriesPage({@required this.job});
  final Job job;

  static Future<void> show(BuildContext context, Job job) async {
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.jobEntriesPage,
      arguments: job,
    );
  }

  Future<void> _deleteEntry(BuildContext context, Entry entry) async {
    try {
      final database = Provider.of<FirestoreDatabase>(context, listen: false);
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
    final database = Provider.of<FirestoreDatabase>(context, listen: false);
    return StreamBuilder<Job>(
      stream: database.jobStream(jobId: job.id),
      builder: (context, snapshot) {
        final job = snapshot.data;
        final jobName = job?.name ?? '';
        return Scaffold(
          appBar: AppBar(
            elevation: 2.0,
            title: Text(jobName),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: () => EditJobPage.show(
                  context,
                  job: job,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () => EntryPage.show(
                  context: context,
                  job: job,
                ),
              ),
            ],
          ),
          body: _buildContent(context, job),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, Job job) {
    final database = Provider.of<FirestoreDatabase>(context, listen: false);
    return StreamBuilder<List<Entry>>(
      stream: database.entriesStream(job: job),
      builder: (context, snapshot) {
        return ListItemsBuilder<Entry>(
          snapshot: snapshot,
          itemBuilder: (context, entry) {
            return DismissibleEntryListItem(
              dismissibleKey: Key('entry-${entry.id}'),
              entry: entry,
              job: job,
              onDismissed: () => _deleteEntry(context, entry),
              onTap: () => EntryPage.show(
                context: context,
                job: job,
                entry: entry,
              ),
            );
          },
        );
      },
    );
  }
}
