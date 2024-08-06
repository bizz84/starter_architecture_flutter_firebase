import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/routing/app_router.dart';
import 'package:flutter_starter_base_app/src/constants/svg_loader.dart';

StateProvider<bool> showBottomNav = StateProvider((ref) => true);

class CustomNavigationBar extends ConsumerWidget {
  const CustomNavigationBar({super.key, required this.child});

  final Widget child;

  void _onItemTapped(BuildContext context, WidgetRef ref, int index) {
    ref.read(currentMainRouteIndexProvider.notifier).state = index;
    context.go('/${bottomNavRoutes[index].name}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => Theme(
        data: Theme.of(context).copyWith(),
        child: Scaffold(
          bottomNavigationBar: ref.watch(showBottomNav)
              ? BottomNavigationBar(
                  selectedItemColor: CustomColors().primaryTextColor,
                  unselectedItemColor: CustomColors().darkGrayText,
                  onTap: (int index) => _onItemTapped(context, ref, index),
                  backgroundColor: CustomColors().darkestGrayBG,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: ref.watch(currentMainRouteIndexProvider),
                  showUnselectedLabels: true,
                  showSelectedLabels: true,
                  unselectedFontSize: 12,
                  selectedFontSize: 12,
                  items: [
                      BottomNavigationBarItem(
                          icon: SVGLoader().homeInactiveIcon,
                          activeIcon: SVGLoader().homeIcon,
                          label: LocaleKeys.common_home.tr()),
                      BottomNavigationBarItem(
                          icon: SVGLoader().accountInactiveIcon,
                          activeIcon: SVGLoader().accountIcon,
                          label: LocaleKeys.common_account.tr()),
                      BottomNavigationBarItem(
                          icon: SVGLoader().reportsInactiveIcon,
                          activeIcon: SVGLoader().reportsIcon,
                          label: LocaleKeys.common_reports.tr()),
                    ])
              : null,
          body: child,
        ),
      );
}
