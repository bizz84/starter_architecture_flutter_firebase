import 'package:flutter/material.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';


class ItemListTile extends StatelessWidget {
  const ItemListTile({Key? key, required this.item, this.onTap})
      : super(key: key);
  final Item item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = context.read(firebaseAuthProvider);
    final user = firebaseAuth.currentUser!;
    final String emailAbsolute = user.email!;
    String tag = '[on listing]';
    if(item.bought) tag = '[bought]';  
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.category + " " + tag),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
