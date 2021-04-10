import 'package:flutter/cupertino.dart';
import '../app/home/Templates/item_details.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/item.dart';
import 'package:starter_architecture_flutter_firebase/app/home/history/history_details.dart';

class CupertinoTabViewRoutes {
  static const itemEntriesPage = '/item-entries-page';
  static const sellProductPage = '/sell-product-page';
}

class CupertinoTabViewRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CupertinoTabViewRoutes.itemEntriesPage:
        final item = settings.arguments as Item;
        return CupertinoPageRoute(
          builder: (_) => ItemEntriesPage(item: item),
          settings: settings,
          fullscreenDialog: false,
        );
      case CupertinoTabViewRoutes.sellProductPage: 
        final item = settings.arguments as Item;
        return CupertinoPageRoute(
          builder: (_) => SellProductPage(item: item),
          settings: settings,
          fullscreenDialog: false,
        );
    }
    return null;
  }
}
