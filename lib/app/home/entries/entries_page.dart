import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:starter_architecture_flutter_firebase/app/home/entries/entries_view_model.dart';
import 'package:starter_architecture_flutter_firebase/app/home/entries/entries_list_tile.dart';
import 'package:starter_architecture_flutter_firebase/app/home/jobs/list_items_builder.dart';
import 'package:starter_architecture_flutter_firebase/constants/strings.dart';
import 'package:starter_architecture_flutter_firebase/services/firestore_database.dart';

class EntriesPage extends StatefulWidget {
  static Widget create(BuildContext context) {
    final database = Provider.of<FirestoreDatabase>(context, listen: false);
    return Provider<EntriesViewModel>(
      create: (_) => EntriesViewModel(database: database),
      child: EntriesPage(),
    );
  }

  @override
  _EntriesPageState createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  Stream<List<EntriesListTileModel>> _entriesTileModelStream;

  @override
  void initState() {
    super.initState();
    final vm = context.read<EntriesViewModel>();
    _entriesTileModelStream = vm.entriesTileModelStream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.entries),
        elevation: 2.0,
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    return StreamBuilder<List<EntriesListTileModel>>(
      stream: _entriesTileModelStream,
      builder: (context, snapshot) {
        context
            .watch<Logger>()
            .d('Entries StreamBuilder rebuild: ${snapshot.connectionState}');
        return ListItemsBuilder<EntriesListTileModel>(
          snapshot: snapshot,
          itemBuilder: (context, model) => EntriesListTile(model: model),
        );
      },
    );
  }
}
