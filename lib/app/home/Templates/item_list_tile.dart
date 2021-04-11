import 'package:flutter/material.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    String tag = '[on listing]; ';
    Color c = Colors.white;
    if(item.bought){
      tag = '[bought]; ';  
      c = Colors.red.shade100;
    }
    else{
      c = Colors.blue.shade100;
    }
    if(item.sellerUUID == user.uid) c = Colors.grey.shade200;
    DateTime date1 = DateTime.parse(item.time.toDate().toString());
    DateTime date2 = DateTime.parse(Timestamp.now().toDate().toString());
    String dur = "";
    if (date2.difference(date1).inDays < 1){
      dur = date2.difference(date1).inHours.toString() + " hour ago";      
    }
    else{
      dur = date2.difference(date1).inDays.toString() + " day ago";
    } 
    return ListTile(
      title: Text(item.name),
      tileColor: c,
      subtitle: Text(item.category + " " + tag + "posted " + dur),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
