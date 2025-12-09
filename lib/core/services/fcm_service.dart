import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FcmService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// استدعِها بعد تسجيل الدخول مباشرة
  Future<void> registerDeviceToken(String userId) async {
    try {
      // الحصول على التوكن الحالي من Firebase
      final token = await _firebaseMessaging.getToken();
      if (token == null) {
        print('⚠️ FCM Token is null');
        return;
      }

      // تحديد نوع النظام (Android / iOS / Web)
      final platform = _getPlatform();

      // تحقق لو التوكن ده متسجل قبل كده لنفس المستخدم
      final existing = await _supabase
          .from('user_devices')
          .select()
          .eq('user_id', userId)
          .eq('fcm_token', token)
          .maybeSingle();

      if (existing == null) {
        // إدخال توكن جديد
        await _supabase.from('user_devices').insert({
          'user_id': userId,
          'fcm_token': token,
          'platform': platform,
        });

        print('✅ FCM token added successfully');
      } else {
        print('ℹ️ Token already exists, skipping insert.');
      }

    } catch (e) {
      print('❌ Error registering FCM token: $e');
    }
  }

  /// Helper لتحديد نوع المنصة
  String _getPlatform() {
    if (const bool.fromEnvironment('dart.library.html')) {
      return 'web';
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return 'android';
        case TargetPlatform.iOS:
          return 'ios';
        default:
          return 'unknown';
      }
    }
  }
}
