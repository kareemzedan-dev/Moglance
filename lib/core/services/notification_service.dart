import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'admin_service.dart';

class NotificationService {
  final String supabaseFunctionUrl =
      "https://bztszvzfcnbfmsxkhkhn.supabase.co/functions/v1/send-notification";

  final String supabaseServiceRoleKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ6dHN6dnpmY25iZm1zeGtoa2huIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1NjY2NzU3NywiZXhwIjoyMDcyMjQzNTc3fQ._POj9XngPVg8dL23pkfMVGVt3xdMIVYbSd1XOxFeH1I";

  /// Send notification to a user
  Future<Map<String, dynamic>> sendNotification({
    required String receiverId,
    required String title,
    required String body,
  }) async {
    try {
      final url = Uri.parse(supabaseFunctionUrl);

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $supabaseServiceRoleKey',
        },
        body: jsonEncode({
          'receiverId': receiverId,
          'title': title,
          'body': body,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('✅ Notification sent successfully: ${response.body}');
        return responseData;
      } else {
        print('❌ Failed to send notification: ${response.body}');
        return responseData;
      }
    } catch (e) {
      print('❌ Error sending notification: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  /// إرسال إشعار لعدة مشرفين
  Future<Map<String, dynamic>> sendNotificationToAdmins({
    required List<String> adminIds,
    required String title,
    required String body,
    Map<String, dynamic>? extraData,
  }) async {
    try {
      final results = <Map<String, dynamic>>[];
      int successful = 0;
      int failed = 0;

      // إرسال إشعار منفصل لكل admin
      for (String adminId in adminIds) {
        final result = await sendNotification(
          receiverId: adminId,
          title: title,
          body: body,
        );

        results.add({
          'admin_id': adminId,
          'success': result['success'] ?? false,
          'message': result['success'] ?? false ? 'Notification sent' : result['error'] ?? 'Unknown error',
        });

        if (result['success'] == true) {
          successful++;
        } else {
          failed++;
        }
      }

      return {
        'success': successful > 0,
        'results': results,
        'summary': {
          'total': adminIds.length,
          'successful': successful,
          'failed': failed,
        },
      };

    } catch (e) {
      print('❌ Error sending notifications to admins: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  /// إرسال إشعار لجميع المشرفين مرة واحدة
  Future<Map<String, dynamic>> sendNotificationToAllAdmins({
    required String title,
    required String body,
  }) async {
    try {

      final adminService = AdminService(supabase: Supabase.instance.client);
      final ids = await adminService.getAllAdminIds();
      return await sendNotificationToAdmins(
        adminIds: ids,
        title: title,
        body: body,
      );
    } catch (e) {
      print('❌ Error sending notification to all admins: $e');
      return {'success': false, 'error': e.toString()};
    }
  }


}