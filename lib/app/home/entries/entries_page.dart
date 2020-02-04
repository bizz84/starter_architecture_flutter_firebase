import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_architecture_flutter_firebase/app/home/entries/entries_view_model.dart';
import 'package:starter_architecture_flutter_firebase/app/home/entries/entries_list_tile.dart';
import 'package:starter_architecture_flutter_firebase/app/home/jobs/list_items_builder.dart';
import 'package:starter_architecture_flutter_firebase/constants/strings.dart';
import 'package:starter_architecture_flutter_firebase/services/firestore_database.dart';

class EntriesPage extends StatelessWidget {
  static Widget create(BuildContext context) {
    final database = Provider.of<FirestoreDatabase>(context, listen: false);
    return Provider<EntriesViewModel>(
      create: (_) => EntriesViewModel(database: database),
      child: EntriesPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.entries),
        elevation: 2.0,
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final vm = Provider.of<EntriesViewModel>(context);
    return StreamBuilder<List<EntriesListTileModel>>(
      stream: vm.entriesTileModelStream,
      builder: (context, snapshot) {
        return ListItemsBuilder<EntriesListTileModel>(
          snapshot: snapshot,
          itemBuilder: (context, model) => EntriesListTile(model: model),
        );
      },
    );
  }
}
