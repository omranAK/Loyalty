import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_system_mobile/data/models/charity_model.dart';
import 'package:loyalty_system_mobile/data/repository/notifications_repo.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';
import 'package:loyalty_system_mobile/presentation/screens/auth_otp_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/auth_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/barcode_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/charity_detail_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/info_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/notifications_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/profile_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/store_detail_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/tab_screen.dart';
import 'package:loyalty_system_mobile/presentation/widgets/video_player.dart';
import './constant/constant_data.dart';
import 'logic/notifications/bloc/notifications_bloc.dart';

class AppRouter {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      //tabScreen
      case tabScreen:
        return MaterialPageRoute(builder: (_) => const Tabs());
      //storeDetail Screen
      case storeDetail:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => StoreDetailScreen(
                  storeID: args['storeID'],
                  storeName: args['name'],
                ));

      //Profile Screen
      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      //Auth Screen
      case authscreen:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(),
        );

      //Auth Otp Screen
      case authOtp:
        final args = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AuthOtp(
            data: args,
          ),
        );

      //Charity Detail Screen
      case charitydetaile:
        final args = routeSettings.arguments as CharityModel;
        return MaterialPageRoute(
          builder: (_) => CharityDetailScreen(
            charity: args,
          ),
        );

      //Video Player Screen
      case videoplayer:
        return MaterialPageRoute(
          builder: (_) => const VideoPlayerScreen(),
        );
      //Notifications Screen
      case notification:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => NotificationsBloc(
              NotificationsRepository(
                externalService: ExternalService(),
              ),
            ),
            child: const NotificationsScreen(),
          ),
        );

      //About Screen
      case about:
        return MaterialPageRoute(
          builder: (_) => const InfoScren(),
        );
      case barcode:
        return MaterialPageRoute(builder: (_) => const BarCodeScreen());
      default:
        return null;
    }
  }
}
