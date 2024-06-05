import 'package:flutter/material.dart';
import 'package:loyalty_system_mobile/data/models/charity_model.dart';
import 'package:loyalty_system_mobile/presentation/screens/auth_otp_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/auth_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/charity_detail_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/profile_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/store_detail_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/tab_screen.dart';
import 'package:loyalty_system_mobile/presentation/widgets/video_player.dart';
import './constant/constant_data.dart';

class AppRouter {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case tabScreen:
        return MaterialPageRoute(builder: (_) => const Tabs());
      case storeDetail:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => StoreDetailScreen(
                  storeID: args['storeID'],
                  storeName: args['name'],
                ));
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case authscreen:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case authOtp:
        final args = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AuthOtp(
            data: args,
          ),
        );
      case charitydetaile:
        final args = routeSettings.arguments as CharityModel;
        return MaterialPageRoute(
          builder: (_) => CharityDetailScreen(
            charity: args,
          ),
        );
      case videoplayer:
        return MaterialPageRoute(
          builder: (_) => const VideoPlayerScreen(),
        );
      default:
        return null;
    }
  }
}
