
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:typed_data';
class FirebaseNotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // تهيئة الإشعارات المحلية
  static Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitializationSettings =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        // التعامل مع النقر على الإشعار
        print('Notification clicked: ${notificationResponse.payload}');
      },
    );
  }

  // تهيئة إشعارات FCM
  static Future<void> initializeFCM() async {
    // طلب التصاريح
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    print('Notification permissions: ${settings.authorizationStatus}');

    // معالجة الرسائل في الخلفية (عندما يكون التطبيق مغلقاً)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // معالجة الرسائل في المقدمة
    FirebaseMessaging.onMessage.listen(_onMessage);

    // معالجة الرسائل عندما يكون التطبيق في الخلفية
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // الحصول على الـ token
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    // تحديث الـ token عند التغيير
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print('New FCM Token: $newToken');
      // أرسل الـ token الجديد للسيرفر
      _sendTokenToServer(newToken);
    });
  }

  // معالج الرسائل في الخلفية
  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling background message: ${message.messageId}');

    // عرض الإشعار حتى عندما يكون التطبيق مغلقاً
    await _showNotification(
      title: message.data['title'] ?? message.notification?.title ?? 'New Message',
      body: message.data['body'] ?? message.notification?.body ?? 'You have a new message',
      payload: message.data.toString(),
    );
  }

  // معالج الرسائل في المقدمة
  static Future<void> _onMessage(RemoteMessage message) async {
    print('Handling foreground message: ${message.messageId}');

    await _showNotification(
      title: message.data['title'] ?? message.notification?.title ?? 'New Message',
      body: message.data['body'] ?? message.notification?.body ?? 'You have a new message',
      payload: message.data.toString(),
    );
  }

  // معالج عند فتح الإشعار
  static Future<void> _onMessageOpenedApp(RemoteMessage message) async {
    print('Notification opened: ${message.messageId}');
    // التنقل للشاشة المناسبة
  }

  // عرض الإشعار المحلي
  static Future<void> _showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'high_priority_channel', // استخدام القناة عالية الأولوية
      'High Priority Notifications',
      channelDescription: 'High priority notifications for important messages',
      importance: Importance.max, // أعلى أهمية
      priority: Priority.max, // أعلى أولوية
      playSound: true,
      enableVibration: true,
      vibrationPattern: Int64List.fromList([1000, 1000, 1000, 1000]),
      // إعدادات للشاشة المقفولة
      fullScreenIntent: true, // يظهر حتى على الشاشة المقفولة
      autoCancel: true,
      showWhen: true,
      visibility: NotificationVisibility.public, // مرئي على الشاشة المقفولة
      timeoutAfter: 5000, // يختفي بعد 5 ثواني
      styleInformation: BigTextStyleInformation(body),
    );

    const DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'default',
      badgeNumber: 1,
      subtitle: 'New Message',
      threadIdentifier: 'important-messages',
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    try {
      await _flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch.remainder(100000),
        title,
        body,
        notificationDetails,
        payload: payload,
      );
      print('✅ High priority notification shown');
    } catch (e) {
      print('❌ Error showing high priority notification: $e');
    }
  }

  static Future<void> _sendTokenToServer(String token) async {
    try {

      print('Sending token to server: $token');
    } catch (e) {
      print('Error sending token to server: $e');
    }
  }
}