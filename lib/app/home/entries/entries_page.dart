import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/home/entries/entries_view_model.dart';
import 'package:starter_architecture_flutter_firebase/app/home/entries/entries_list_tile.dart';
import 'package:starter_architecture_flutter_firebase/app/home/jobs/list_items_builder.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';
import 'package:starter_architecture_flutter_firebase/constants/strings.dart';

final entriesTileModelStreamProvider =
    StreamProvider.autoDispose<List<EntriesListTileModel>>(
  (ref) {
    final database = ref.watch(databaseProvider);
    final vm = EntriesViewModel(database: database);
    return vm.entriesTileModelStream;
  },
);

class EntriesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.entries),
        elevation: 2.0,
      ),
      body: _buildContents(context, watch),
    );
  }

  Widget _buildContents(BuildContext context, ScopedReader watch) {
    final entriesTileModelStream = watch(entriesTileModelStreamProvider);
    return ListItemsBuilder<EntriesListTileModel>(
      data: entriesTileModelStream,
      itemBuilder: (context, model) => EntriesListTile(model: model),
    );
  }
}
