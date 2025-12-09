import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/services/supabase_service.dart';
import 'package:taskly/features/messages/data/data_sources/remote/delete_message_remote_data_source/delete_message_remote_data_source.dart';

import '../../../../../../core/utils/network_utils.dart';
@Injectable(as: DeleteMessageRemoteDataSource)
class DeleteMessageRemoteDataSourceImpl extends  DeleteMessageRemoteDataSource{
  final SupabaseService supabaseService;
  DeleteMessageRemoteDataSourceImpl(this.supabaseService);
   @override
  Future<Either<Failures, void>> deleteMessage(String messageId) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure('تحقق من اتصالك بالانترنت'));
      }
      await supabase
          .from('messages')
          .delete()
          .eq('id', messageId);

      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}