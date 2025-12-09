import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/services/supabase_service.dart';
import 'package:taskly/features/messages/data/data_sources/remote/get_order_messages_remote_data_source/get_order_messages_remote_data_source.dart';
import 'package:taskly/features/messages/data/models/message_model.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';

import '../../../../../../core/utils/network_utils.dart';
@Injectable(as: GetOrderMessagesRemoteDataSource)
class GetOrderMessagesRemoteDataSourceImpl extends GetOrderMessagesRemoteDataSource {
  final SupabaseService supabaseService;
  GetOrderMessagesRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, List<MessageEntity>>> getOrderMessages(
      String orderId,
      String currentUserId,
      String otherUserId,
   ) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure('تحقق من اتصالك بالانترنت'));
      }
      final response = await supabaseService.supabaseClient
          .from('messages')
          .select()
          .eq('order_id', orderId)
          .filter('sender_id', 'in', [currentUserId, otherUserId])
          .filter('receiver_id', 'in', [currentUserId, otherUserId])
          .order('created_at', ascending: true);

      print("Supabase response: $response");

      final data = (response as List)
          .map((e) => MessageModel.fromJson(e))
          .toList();

      return Right(data);
    } on PostgrestException catch (e) {
      print("PostgrestException: ${e.message}");
      return Left(ServerFailure(e.message));
    } catch (e) {
      print("Other exception: $e");
      return Left(ServerFailure(e.toString()));
    }
  }
}
