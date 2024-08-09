import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/root/data/providers.dart';
import 'package:flutter_starter_base_app/src/root/domain/contact.dart';
import 'package:flutter_starter_base_app/src/root/presentation/contact_view.dart';

final listItemSelectorProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => RefreshIndicator(
      color: CustomColors().primaryTextColor,
      backgroundColor: CustomColors().darkGrayBG,
      onRefresh: () async => ref.refresh(getDataProvider.future),
      child: ref.watch(getDataProvider).when(
          error: (Object error, StackTrace stackTrace) {
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('$error')))));
            return const Scaffold(
              appBar: CustomAppBar(titleWidget: Text('Cannot Load')),
            );
          },
          loading: () {
            return const Scaffold(body: Directionality(textDirection: TextDirection.ltr, child: SizedBox()));
          },
          data: (List<Contact> contact) {
            return Scaffold(
                appBar: CustomAppBar(
                    titleWidget: Text("Contacts",
                        style: DefaultTheme().defaultTextStyle(20).copyWith(fontWeight: FontWeight.w500)),
                        automaticallyImplyLeading: false),
                body: CustomScrollView(primary: true, scrollDirection: Axis.vertical, slivers: [
                  SliverFillViewport(
                      delegate: SliverChildBuilderDelegate(
                          childCount: 1,
                          (context, index) => Column(children: [
                                Flexible(
                                    child: CarouselSlider(
                                        items: contact.map((e) => ContactView(contact: e)).toList(),
                                        options: CarouselOptions(
                                          initialPage: ref.watch(listItemSelectorProvider),
                                            viewportFraction: 1,
                                            enableInfiniteScroll: false,
                                            height: MediaQuery.of(context).size.height))),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: contact
                                        .asMap()
                                        .entries
                                        .map((entry) => Container(
                                            width: 7.0,
                                            height: 7.0,
                                            margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white.withOpacity(
                                                    ref.watch(listItemSelectorProvider) == entry.key ? 0.9 : 0.4))))
                                        .toList())
                              ]))),
                ]));
          }));
}
