import 'package:flutter/material.dart';
import 'package:loyalty_system_mobile/presentation/screens/auth_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/store_detail_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/tab_screen.dart';
import './constant/constant_data.dart';

class AppRouter {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case tabScreen:
        return MaterialPageRoute(builder: (_) => const Tabs());
      case storeDetail:
        return MaterialPageRoute(builder: (_) => const StoreDetailScreen());
      default:
        return null;
    }
  }
}
