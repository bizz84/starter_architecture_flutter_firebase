import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/common_widgets/select_builder.dart';
import 'package:flutter_starter_base_app/src/common_widgets/state_select/data/providers.dart';
import 'package:flutter_starter_base_app/src/root/domain/item.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_starter_base_app/src/common_widgets/app_bar.dart';
import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_starter_base_app/src/common_widgets/circular_loading_animation.dart';

class StateSelect extends ConsumerWidget {
  const StateSelect({super.key, required this.countryName, this.initialSelection});

  final String countryName;
  final Item? initialSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onStateSelection(List<Item> choosenItemList) {
      if (choosenItemList.length == 1) {
        debugPrint("choosen item: ${choosenItemList.first.label}");
        context.pop(choosenItemList.first);
        return;
      }
      context.pop();
    }

    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: true,
        titleWidget: Text(LocaleKeys.household_state.tr()),
        showHamburgerMenu: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ref.watch(fetchStateListProvider(countryName: countryName)).when(
          data: (List<Item> itemList) {
            return SelectBuilder(
              onSelect: onStateSelection,
              items: itemList,
              initialSelection: initialSelection != null ? [initialSelection!] : null,
            );
          },
          error: (error, stackTrace) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('$error'))));
            });
            return Container();
          },
          loading: () => const LoadingAnimation(),
        ),
      ),
    );
  }
}
