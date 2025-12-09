import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';

abstract class RemoveFavoriteOrderRepo {
  Future<Either<Failures, void>>removeFavoriteOrder(String id);
}