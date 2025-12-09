import 'package:injectable/injectable.dart';

import '../../../../../../core/services/supabase_service.dart';
import '../../../../domain/entities/user_status_entity/user_status_entity.dart';
import '../../../data_sources/remote/user_status_remote_data_source/user_status_remote_data_source.dart';

@Injectable(as: UserStatusRemoteDataSource)
class UserStatusRemoteDataSourceImpl implements UserStatusRemoteDataSource {
  final SupabaseService supabaseService;

  UserStatusRemoteDataSourceImpl(this.supabaseService);

  @override
  Stream<UserStatusEntity> streamUserStatus(String userId) {
    final stream = supabaseService.supabaseClient
        .from('users')
        .stream(primaryKey: ['id'])
        .eq('id', userId)
        .map((records) {
      if (records.isEmpty) {
        return UserStatusEntity(
          isOnline: false,
          lastSeen: DateTime.now(),
        );
      }

      final data = records.first;
      return UserStatusEntity(
        isOnline: data['is_online'] ?? false,
        lastSeen: DateTime.tryParse(data['last_seen'] ?? '') ?? DateTime.now(),
      );
    });

    return stream;
  }
}
