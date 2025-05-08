import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/routing/app_router.dart';

// Listener widget to track screen views. Adapted from:
// https://github.com/flutter/flutter/issues/112196#issuecomment-1680382232
class GoRouterDelegateListener extends ConsumerStatefulWidget {
  const GoRouterDelegateListener({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<GoRouterDelegateListener> createState() =>
      _GoRouterListenerState();
}

class _GoRouterListenerState extends ConsumerState<GoRouterDelegateListener> {
  /// Helper variable for retrieving the GoRouter delegate
  /// Note: using GoRouter.of(context) throws an exception so we use the goRouterProvider instead
  late final routerDelegate = ref.read(goRouterProvider).routerDelegate;

  @override
  void initState() {
    super.initState();
    routerDelegate.addListener(_listener);
  }

  @override
  void dispose() {
    routerDelegate.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    final config = routerDelegate.currentConfiguration;
    final screenName = config.last.route.name;
    if (screenName != null) {
      final pathParams = config.pathParameters;
      // TODO: Add your own logging or analytics screen tracking code
      log('screenName: $screenName, pathParams: $pathParams');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
