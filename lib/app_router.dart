import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_system_mobile/data/repository/profile_repo.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';
import 'package:loyalty_system_mobile/logic/pofile/bloc/profile_bloc.dart';
import 'package:loyalty_system_mobile/presentation/screens/auth_otp_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/auth_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/profile_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/store_detail_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/tab_screen.dart';
import './constant/constant_data.dart';

class AppRouter {
  Route? generateRoute(RouteSettings routeSettings) {
    ExternalService? externalService;
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
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ProfileBloc(
                    ProfileRepository(
                      externalService: externalService!,
                    ),
                  ),
                  child: const ProfileScreen(),
                ));
      case authscreen:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case authOtp:
        final args = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AuthOtp(
            data: args,
          ),
        );
      default:
        return null;
    }
  }
}
