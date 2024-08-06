import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/constants/svg_loader.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';

class HamburgerMenu extends ConsumerWidget {
  final List<HamburgerMenuItem> menuItemList;
  const HamburgerMenu({super.key, required this.menuItemList});
  @override
  Widget build(BuildContext context, WidgetRef ref) => SafeArea(
      child: PopupMenuButton<HamburgerMenuItem>(
          icon: Container(child: SVGLoader().hamburgerMenuIcon),
          clipBehavior: Clip.hardEdge,
          offset: const Offset(20, 0),
          padding: const EdgeInsets.all(0),
          onSelected: (HamburgerMenuItem item) => item.function(),
          itemBuilder: (_) {
            List<PopupMenuEntry<HamburgerMenuItem>> list = List.empty(growable: true);
            for (int i = 0; i < menuItemList.length; i++) {
              list.add(PopupMenuItem<HamburgerMenuItem>(height: 25, value: menuItemList[i], child: menuItemList[i]));
              if (i < menuItemList.length - 1) list.add(const PopupMenuDivider());
            }
            return list;
          }));
}

class HamburgerMenuItem extends StatelessWidget {
  final String title;
  final Widget? tailIcon;
  final Widget? leadIcon;
  final Function function;
  const HamburgerMenuItem({super.key, required this.title, required this.function, this.leadIcon, this.tailIcon});
  @override
  Widget build(BuildContext context) => Row(children: [
        if (leadIcon != null) leadIcon!,
        Text(title, style: TextStyle(color: CustomColors().whitecolor)),
        const Spacer(),
        if (tailIcon != null) tailIcon!
      ]);
}
