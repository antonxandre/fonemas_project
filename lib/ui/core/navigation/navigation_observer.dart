import 'package:flutter/material.dart';

class MikiNavigationObserver extends NavigatorObserver {
  final String name;

  MikiNavigationObserver({required this.name});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final routeName = route.settings.name ?? route.settings.arguments?.toString() ?? route.toString();
    debugPrint('[$name] Navigated to screen: $routeName');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    final poppedName = route.settings.name ?? route.settings.arguments?.toString() ?? route.toString();
    final previousName = previousRoute?.settings.name ?? 'None';
    debugPrint('[$name] Returned from screen: $poppedName to: $previousName');
  }
}
