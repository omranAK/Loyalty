import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loyalty_system_mobile/constant/imports.dart';

Future<void> handelBackgroundMessage(RemoteMessage message) async {}

class FirebaseApi {
  final navigatorKey = GlobalKey<NavigatorState>();
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // final _androidChannel = const AndroidNotificationChannel(
  //   '@string/default_notification_channel_id',
  //   'High Importance Notifications',
  //   description: 'This channel is used for important notifications',
  //   importance: Importance.defaultImportance,
  // );
  // final _localNotifications = FlutterLocalNotificationsPlugin();

  Future inirLocalNotifications() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('logo');
    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
    //const ios = DarwinInitializationSettings();
    // const android = AndroidInitializationSettings('@drawable/ic_launcher');
    // const setting = InitializationSettings(android: android);

    // await _localNotifications.initialize(setting);
    // final platform = _localNotifications.resolvePlatformSpecificImplementation<
    //     AndroidFlutterLocalNotificationsPlugin>();
    // await platform?.createNotificationChannel(_androidChannel);
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName'),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int? id, String? title, String? body, String? payload}) async {
    return notificationsPlugin.show(id!, title, body, notificationDetails());
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.onBackgroundMessage(handelBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      showNotification(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        payload: jsonEncode(message.toMap()),
      );
      // _localNotifications.show(
      //     notification.hashCode,
      //     notification.title,
      //     notification.body,
      //     NotificationDetails(
      //       android: AndroidNotificationDetails(
      //         _androidChannel.id,
      //         _androidChannel.name,
      //         channelDescription: _androidChannel.description,
      //         icon: '@drawable/ic_launcher',
      //       ),
      //     ),
      //     payload: jsonEncode(message.toMap()));
    });
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMtoken = await _firebaseMessaging.getToken();
    if (fCMtoken != null) {
      CacheManager.setdeviceToken(fCMtoken);
      NotificationsRepository(externalService: ExternalService())
          .registerToken({'device_token': fCMtoken}, 'add_device_key');
    }
    initPushNotifications();
    inirLocalNotifications();
  }

  Future<void> deleteToken() async {
    await _firebaseMessaging.deleteToken();
  }
}
