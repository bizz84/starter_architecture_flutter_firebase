import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/features/household/domain/providers.dart';
import 'package:flutter_starter_base_app/src/global_providers/global_providers.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/features/household/domain/household.dart';
import 'package:flutter_starter_base_app/src/features/household/presentation/household_view.dart';

final listItemSelectorProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => RefreshIndicator(
      color: CustomColors().primaryTextColor,
      backgroundColor: CustomColors().darkGrayBG,
      onRefresh: () async => ref.refresh(fetchHouseholdListProvider.future),
      child: ref.watch(fetchHouseholdListProvider).when(
          error: (Object error, StackTrace stackTrace) {
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('$error')))));
            return const Scaffold(
              appBar: CustomAppBar(titleWidget: Text('Cannot Load Household')),
            );
          },
          loading: () => const Scaffold(body: Directionality(textDirection: TextDirection.ltr, child: SizedBox())),
          data: (List<Household> householdList) {
            List<HouseholdView> householdViewList = householdList.map((household) => HouseholdView(household: household)).toList();
            WidgetsBinding.instance.addPostFrameCallback((_) => ref.read(currentHousehold.notifier).state == null
                ? ref.read(currentHousehold.notifier).state = householdList[0]
                : null);
            return Scaffold(
                appBar: CustomAppBar(
                    titleWidget: Text(householdList[ref.watch(listItemSelectorProvider)].householdName,
                        style: DanlawTheme().defaultTextStyle(20).copyWith(fontWeight: FontWeight.w500)),
                    automaticallyImplyLeading: false),
                body: CustomScrollView(primary: true, scrollDirection: Axis.vertical, slivers: [
                  SliverFillViewport(
                      delegate: SliverChildBuilderDelegate(
                          childCount: 1,
                          (context, index) => Column(children: [
                                Flexible(
                                    child: CarouselSlider(
                                        items: householdViewList,
                                        options: CarouselOptions(
                                          initialPage: ref.watch(listItemSelectorProvider),
                                            viewportFraction: 1,
                                            enableInfiniteScroll: false,
                                            height: MediaQuery.of(context).size.height,
                                            onPageChanged: (index, a) {
                                              ref.read(currentHousehold.notifier).state = householdList[index];
                                              ref.read(listItemSelectorProvider.notifier).update((_) => index);
                                            }))),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: householdViewList
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
