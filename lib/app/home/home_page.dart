import 'package:flutter/material.dart';
import 'package:starter_architecture_flutter_firebase/app/home/account/account_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/cupertino_home_scaffold.dart';
import 'package:starter_architecture_flutter_firebase/app/home/entries/buy_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/sells/sells_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/search/search_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.search;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.sell: GlobalKey<NavigatorState>(),
    TabItem.buy: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>()
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.search: (_) => SearchPage(),
      TabItem.sell: (_) => JobsPage(),
      TabItem.buy: (_) => BuyPage(),
      TabItem.account: (_) => AccountPage()
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      navigatorKeys[tabItem]!.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !(await navigatorKeys[_currentTab]!.currentState?.maybePop() ??
              false),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
