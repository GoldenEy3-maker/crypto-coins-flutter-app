import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:talker_flutter/talker_flutter.dart";

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize({required Talker talker}) async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _requestPermission(talker);
    await _setupMessageHandlers();
    final token = await _messaging.getToken();
    talker.info("FCM Token: $token");
  }

  Future<void> _requestPermission(Talker talker) async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    talker.info("Permission status: ${settings.authorizationStatus}");
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) return;

    const channel = AndroidNotificationChannel(
      "high_importance_channel",
      "High Importance Notifications",
      description: "This channel is used for high importance notifications.",
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid = AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );

    const initializationSettingsDarwin = DarwinInitializationSettings();

    InitializationSettings initializationSettings =
        const InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    await _localNotifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );

    _isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            "high_importance_channel",
            "High Importance Notifications",
            channelDescription:
                "This channel is used for high importance notifications.",
            importance: Importance.high,
            priority: Priority.high,
            icon: "@mipmap/ic_launcher",
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  Future<void> _setupMessageHandlers() async {
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    if (message.data["type"] == "chat") {
      // open chat screen
    }
  }
}
