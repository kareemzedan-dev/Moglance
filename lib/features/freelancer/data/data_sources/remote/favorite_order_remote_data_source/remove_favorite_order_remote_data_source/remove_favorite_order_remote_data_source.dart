import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';


abstract class  RemoveFavoriteOrderRemoteDataSource {
  Future<Either<Failures, void>>removeFavoriteOrder(String id);
}