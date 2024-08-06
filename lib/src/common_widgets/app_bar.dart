import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/constants/svg_loader.dart';
import 'package:flutter_starter_base_app/src/utils/feature_constraints.dart';
import 'package:flutter_starter_base_app/src/common_widgets/hamburger_menu.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Widget? titleWidget;
  final bool automaticallyImplyLeading;
  final Widget? leading;
  final bool showHamburgerMenu;
  final Widget? customActionIcon;
  final VoidCallback? onCustomActionPressed;
  final bool showBackButton;

  @override
  final Size preferredSize;
  const CustomAppBar({
    super.key,
    required this.titleWidget,
    this.automaticallyImplyLeading = false,
    this.leading,
    this.showHamburgerMenu = true,
    this.customActionIcon,
    this.onCustomActionPressed,
    this.showBackButton = false,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context, WidgetRef ref) => AppBar(
          automaticallyImplyLeading: automaticallyImplyLeading && leading == null,
          leadingWidth: 100,
          leading: showBackButton
              ? InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const Icon(CupertinoIcons.back),
                    Text(LocaleKeys.common_back.tr(),
                        style: TextStyle(fontSize: 17, color: CustomColors().primaryTextColor))
                  ]))
              : leading,
          titleSpacing: 0,
          centerTitle: true,
          title: titleWidget ?? Container(),
          actions: [
            if (showHamburgerMenu)
              SizedBox(
                  child: HamburgerMenu(menuItemList: [
                HamburgerMenuItem(
                    title: LocaleKeys.btn_addHousehold.tr(),
                    function: () async => await FeatureConstraints()
                            .canCreateFeature(ref, featureType: FeatureType.household, overrideThreshold: true)
                            .then((validation) {
                          if (validation) {
                            context.push('/${AppRoute.addHousehold.name}');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("You have reached maximum limit of households")));
                          }
                        })),
                HamburgerMenuItem(
                    title: LocaleKeys.charger_wizard_addChargerTitle.tr(),
                    function: () async => await FeatureConstraints()
                            .canCreateFeature(ref, featureType: FeatureType.charger, overrideThreshold: true)
                            .then((validation) {
                          if (validation) {
                            context.push('/${AppRoute.addCharger.name}');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("You have reached maximum limit of chargers")));
                          }
                        })),
                HamburgerMenuItem(
                    title: LocaleKeys.vehicle_wizard_addVehicleTitle.tr(),
                    function: () async => await FeatureConstraints()
                            .canCreateFeature(ref, featureType: FeatureType.vehicle)
                            .then((validation) {
                          if (validation) {
                            context.push('/${AppRoute.addVehicle.name}');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("You have reached maximum limit of vehicles")));
                          }
                        })),
                HamburgerMenuItem(
                    title: LocaleKeys.btn_support.tr(),
                    tailIcon: Padding(padding: const EdgeInsets.only(right: 6), child: SVGLoader().externalLinkIcon),
                    function: () async => await launchUrl(Uri.parse('https://www.danlawinc.com/contact-us'),
                        mode: LaunchMode.externalApplication)),
                HamburgerMenuItem(
                    title: LocaleKeys.btn_accessaries.tr(),
                    function: () async =>
                        await launchUrl(Uri.parse('https://www.danlawinc.com'), mode: LaunchMode.externalApplication),
                    tailIcon: Padding(padding: const EdgeInsets.only(right: 6), child: SVGLoader().externalLinkIcon)),
                HamburgerMenuItem(
                    title: LocaleKeys.btn_logout.tr(),
                    function: () async => WidgetsBinding.instance
                        .addPostFrameCallback((_) => context.goNamed(AppRoute.logoutPageTransition.name)),
                    tailIcon: const Icon(Icons.logout))
              ])),
            if (!showHamburgerMenu && customActionIcon != null)
              IconButton(icon: customActionIcon!, onPressed: onCustomActionPressed)
          ]);
}
