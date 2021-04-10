import 'package:flutter/material.dart';
import 'package:starter_architecture_flutter_firebase/constants/keys.dart';
import 'package:starter_architecture_flutter_firebase/constants/strings.dart';

enum TabItem { history, browse, account }

class TabItemData {
  const TabItemData(
      {required this.key, required this.title, required this.icon});

  final String key;
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.history: TabItemData(
      key: Keys.historyTab,
      title: Strings.history,
      icon: Icons.view_headline,
    ),

    TabItem.browse: TabItemData(
        key: Keys.browseTab,
        title: Strings.browse,
        icon: Icons.search
    ),

    TabItem.account: TabItemData(
      key: Keys.accountTab,
      title: Strings.account,
      icon: Icons.person,
    )
  };
}
