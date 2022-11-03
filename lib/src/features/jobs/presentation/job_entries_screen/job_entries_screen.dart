import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/data/firestore_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/models/job.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/presentation/job_entries_screen/job_entries_list.dart';
import 'package:starter_architecture_flutter_firebase/src/routing/app_router.dart';

class JobEntriesScreen extends ConsumerWidget {
  const JobEntriesScreen({required this.jobId, this.job});
  final JobID jobId;
  final Job? job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (job != null) {
      // show contents directly
      return JobEntriesPageContents(job: job!);
    } else {
      // else watch data and map to the UI
      final jobAsync = ref.watch(jobStreamProvider(jobId));
      // TODO: Test this on web
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
        title: Consumer(
          builder: (context, ref, child) {
            final jobAsyncValue = ref.watch(jobStreamProvider(job.id));
            return jobAsyncValue.when(
              data: (job) => Text(job.name),
              loading: () => SizedBox.shrink(),
              error: (_, __) => SizedBox.shrink(),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
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
