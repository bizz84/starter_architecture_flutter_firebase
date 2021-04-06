import 'package:flutter/material.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/job.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';


class JobListTile extends StatelessWidget {
  const JobListTile({Key? key, required this.job, this.onTap})
      : super(key: key);
  final Job job;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = context.read(firebaseAuthProvider);
    final user = firebaseAuth.currentUser!;
    final String emailAbsolute = user.email!;
    return ListTile(
      title: Text(job.name),
      subtitle: Text(emailAbsolute),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
