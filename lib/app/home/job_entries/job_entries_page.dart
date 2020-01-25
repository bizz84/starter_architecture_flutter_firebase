import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:starter_architecture_flutter_firebase/app/home/job_entries/entry_list_item.dart';
import 'package:starter_architecture_flutter_firebase/app/home/job_entries/entry_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/jobs/edit_job_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/jobs/list_items_builder.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/entry.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/job.dart';
import 'package:starter_architecture_flutter_firebase/common_widgets/platform_exception_alert_dialog.dart';
import 'package:starter_architecture_flutter_firebase/routing/cupertino_tab_view_router.gr.dart';
import 'package:starter_architecture_flutter_firebase/services/database.dart';

class JobEntriesPage extends StatelessWidget {
  const JobEntriesPage({@required this.database, @required this.job});
  final FirestoreDatabase database;
  final Job job;

  static Future<void> show(BuildContext context, Job job) async {
    final FirestoreDatabase database =
        Provider.of<FirestoreDatabase>(context, listen: false);
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRouter.jobEntriesPage,
      arguments: JobEntriesPageArguments(database: database, job: job),
    );
  }

  Future<void> _deleteEntry(BuildContext context, Entry entry) async {
    try {
      await database.deleteEntry(entry);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    database: database,
                    job: job,
                  ),
                ),
              ],
            ),
            body: _buildContent(context, job),
          );
        });
  }

  Widget _buildContent(BuildContext context, Job job) {
    return StreamBuilder<List<Entry>>(
      stream: database.entriesStream(job: job),
      builder: (context, snapshot) {
        return ListItemsBuilder<Entry>(
          snapshot: snapshot,
          itemBuilder: (context, entry) {
            return DismissibleEntryListItem(
              key: Key('entry-${entry.id}'),
              entry: entry,
              job: job,
              onDismissed: () => _deleteEntry(context, entry),
              onTap: () => EntryPage.show(
                context: context,
                database: database,
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
