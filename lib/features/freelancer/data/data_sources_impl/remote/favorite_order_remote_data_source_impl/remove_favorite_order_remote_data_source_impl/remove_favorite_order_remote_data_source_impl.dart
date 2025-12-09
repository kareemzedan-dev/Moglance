import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/services/supabase_service.dart';
import '../../../../data_sources/remote/favorite_order_remote_data_source/remove_favorite_order_remote_data_source/remove_favorite_order_remote_data_source.dart';



@Injectable(as: RemoveFavoriteOrderRemoteDataSource)
class RemoveFavoriteOrderRemoteDataSourceImpl implements RemoveFavoriteOrderRemoteDataSource {
  final SupabaseService supabaseService;

  RemoveFavoriteOrderRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, void>> removeFavoriteOrder(String id) async {
    try {
      final deletedRows = await supabaseService.supabaseClient
          .from('favorite_order')
          .delete()
          .eq('id', id);

      print("Supabase delete response: $deletedRows");

// بدل ما تعمل Left لو null أو empty، اعمل Right حتى لو مفيش row
      if (deletedRows == null || (deletedRows is List && deletedRows.isEmpty)) {
        print("No row matched for deletion, but operation considered successful");
        return const Right(null);
      }

      print("Record deleted successfully for id: $id");
      return const Right(null);

    } catch (e, st) {
      print("Exception caught while deleting favorite: $e"); // 🖨️ اطبع الاستثناء
      print(st); // 🖨️ اطبع الـ stack trace عشان تعرف مكان الخطأ
      return Left(ServerFailure(e.toString()));
    }
  }
}
