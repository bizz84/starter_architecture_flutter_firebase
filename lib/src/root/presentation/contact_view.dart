import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/root/data/providers.dart';
import 'package:flutter_starter_base_app/src/root/domain/contact.dart';

final listItemSelectorProvider = StateProvider<int>((ref) => 0);

class ContactView extends ConsumerWidget {
  final Contact contact;

  const ContactView({super.key, required this.contact});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      Center(child:
      Column(
        children: [
          Text("First Name:" + contact.firstname + " Lastname: " +
              contact.lastname),
          Text("Address:"),
          Text(contact.address),
          Text(contact.city + ", " + contact.state + " " + contact.zipcode)
        ],
      )
      );

}
