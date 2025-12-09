import 'dart:io';
import '../../../../../core/services/supabase_service.dart';

Future<String?> uploadProfileImage(
    SupabaseService supabaseService,
    String userId,
    String localPath) async {

  final file = File(localPath);
  final storage = supabaseService.supabaseClient.storage.from('users_avatars');

  final fileName = '$userId-${DateTime.now().millisecondsSinceEpoch}.jpg';

  try {
    await storage.upload(fileName, file);

    final publicUrl = storage.getPublicUrl(fileName);

    return publicUrl;
  } catch (e) {
    print('Upload error: $e');
    return null;
  }
}
