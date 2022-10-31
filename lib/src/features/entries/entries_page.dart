import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/constants/strings.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/entries/entries_list_tile.dart';
import 'package:starter_architecture_flutter_firebase/src/features/entries/entries_view_model.dart';
import 'package:starter_architecture_flutter_firebase/src/features/home/data/firestore_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/list_items_builder.dart';

final entriesTileModelStreamProvider =
    StreamProvider.autoDispose<List<EntriesListTileModel>>(
  (ref) {
    final user = ref.watch(authStateChangesProvider).value;
    if (user == null) {
      throw AssertionError('User can\'t be null when fetching entries');
    }
    final database = ref.watch(databaseProvider);
    final vm = EntriesViewModel(database: database);
    return vm.entriesTileModelStream(user.uid);
  },
);

class EntriesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.entries),
        elevation: 2.0,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final entriesTileModelStream =
              ref.watch(entriesTileModelStreamProvider);
          return ListItemsBuilder<EntriesListTileModel>(
            data: entriesTileModelStream,
            itemBuilder: (context, model) => EntriesListTile(model: model),
          );
        },
      ),
    );
  }
}
