

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/services/supabase_service.dart';
import 'package:taskly/features/messages/data/data_sources/remote/mark_messages_as_read_remote_data_source/mark_messages_as_read_remote_data_source.dart';

import '../../../../../../core/utils/network_utils.dart';
@Injectable(as: MarkMessagesAsReadRemoteDataSource)
class MarkMessagesAsReadRemoteDataSourceImpl extends MarkMessagesAsReadRemoteDataSource{
  final SupabaseService supabaseService;

  MarkMessagesAsReadRemoteDataSourceImpl({required this.supabaseService});

    @override
  Future<Either<Failures, void>> markMessagesAsRead(String orderId, String currentUserId) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure('تحقق من اتصالك بالانترنت'));
      }
      await supabaseService.supabaseClient
          .from('messages')
          .update({
        'seen_at': DateTime.now().toIso8601String(),
      })
          .eq('order_id', orderId)
          .eq('receiver_id', currentUserId)
          .filter('seen_at', 'is', null);


      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}