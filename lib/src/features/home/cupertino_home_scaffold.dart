// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:starter_architecture_flutter_firebase/src/constants/keys.dart';
// import 'package:starter_architecture_flutter_firebase/src/features/home/tab_item.dart';
// import 'package:starter_architecture_flutter_firebase/src/routing/cupertino_tab_view_router.dart';

// @immutable
// class CupertinoHomeScaffold extends StatelessWidget {
//   const CupertinoHomeScaffold({
//     Key? key,
//     required this.currentTab,
//     required this.onSelectTab,
//     required this.widgetBuilders,
//     required this.navigatorKeys,
//   }) : super(key: key);

//   final TabItem currentTab;
//   final ValueChanged<TabItem> onSelectTab;
//   final Map<TabItem, WidgetBuilder> widgetBuilders;
//   final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoTabScaffold(
//       tabBar: CupertinoTabBar(
//         key: const Key(Keys.tabBar),
//         currentIndex: currentTab.index,
//         activeColor: Colors.indigo,
//         items: [
//           _buildItem(TabItem.jobs),
//           _buildItem(TabItem.entries),
//           _buildItem(TabItem.account),
//         ],
//         onTap: (index) => onSelectTab(TabItem.values[index]),
//       ),
//       tabBuilder: (context, index) {
//         final item = TabItem.values[index];
//         return CupertinoTabView(
//           navigatorKey: navigatorKeys[item],
//           builder: (context) => widgetBuilders[item]!(context),
//           onGenerateRoute: CupertinoTabViewRouter.generateRoute,
//         );
//       },
//     );
//   }

//   BottomNavigationBarItem _buildItem(TabItem tabItem) {
//     final itemData = TabItemData.allTabs[tabItem]!;
//     final color = currentTab == tabItem ? Colors.indigo : Colors.grey;
//     return BottomNavigationBarItem(
//       icon: Icon(
//         itemData.icon,
//         key: Key(itemData.key),
//         color: color,
//       ),
//       label: itemData.title,
//     );
//   }
// }
