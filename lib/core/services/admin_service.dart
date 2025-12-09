import 'package:supabase_flutter/supabase_flutter.dart';

class AdminService {
  final SupabaseClient supabase;

  AdminService({required this.supabase});

  Future<List<String>> getAllAdminIds() async {
    try {
      final response = await supabase
          .from('admins')
          .select('id'); // جلب العمود id فقط

      // response بيكون List<Map<String, dynamic>>
      if (response is List) {
        return response
            .map<String>((e) => e['id'].toString())
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('❌ Failed to fetch admin IDs: $e');
      return [];
    }
  }
}
