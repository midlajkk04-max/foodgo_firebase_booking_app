import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging firebaseMessaging =
      FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initNotification() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);

    await localNotifications.initialize(initializationSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'food_channel',
      'Food Notification',
      description: 'Notification for new food added',
      importance: Importance.high,
    );

    await localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;

      if (notification != null) {
        localNotifications.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'food_channel',
              'Food Notification',
              channelDescription: 'Notification for new food added',
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Background notification click aayi");
      print(message.data);
    });

   
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      print("Terminated notification click aayi");
      print(initialMessage.data);
    }

    String? token = await firebaseMessaging.getToken();
    print("FCM TOKEN: $token");
  }

 
  static Future<void> showNotification(String name) async {
    await localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      "New Food Added 🍔",
      "$name is now available",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'food_channel',
          'Food Notification',
          channelDescription: 'Notification for new food added',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }
}
