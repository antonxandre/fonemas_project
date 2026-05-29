import 'package:flutter/material.dart';

class MikiNavigationObserver extends NavigatorObserver {
  final String name;

  MikiNavigationObserver({required this.name});

  String _cleanRouteName(Route<dynamic>? route) {
    if (route == null) return 'None';
    
    final settingsName = route.settings.name;
    if (settingsName != null && settingsName.isNotEmpty && settingsName != 'null') {
      return settingsName;
    }
    
    final args = route.settings.arguments;
    if (args != null) {
      final argsStr = args.toString();
      if (argsStr.isNotEmpty && argsStr != 'null') {
        return argsStr;
      }
    }
    
    // Return simplified class name to avoid printing detailed internal representations
    final routeType = route.runtimeType.toString().split('<').first;
    return '$routeType(unnamed)';
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final routeName = _cleanRouteName(route);
    debugPrint('[$name] Navigated to screen: $routeName');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    final poppedName = _cleanRouteName(route);
    final previousName = _cleanRouteName(previousRoute);
    debugPrint('[$name] Returned from screen: $poppedName to: $previousName');
  }
}
