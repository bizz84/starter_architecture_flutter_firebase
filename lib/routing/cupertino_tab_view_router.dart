import 'package:flutter/cupertino.dart';
import 'package:starter_architecture_flutter_firebase/app/home/browse/browse_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/browse/search_page_result.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/item.dart';
import 'package:starter_architecture_flutter_firebase/app/home/history/sell_product_page.dart';

class CupertinoTabViewRoutes {
  static const sellProductPage = '/sell-product-page';
  static const searchResultPage = '/search-result-page';
}

class CupertinoTabViewRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CupertinoTabViewRoutes.searchResultPage:
        return CupertinoPageRoute(
          builder: (_) => SearchPageResult(),
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
