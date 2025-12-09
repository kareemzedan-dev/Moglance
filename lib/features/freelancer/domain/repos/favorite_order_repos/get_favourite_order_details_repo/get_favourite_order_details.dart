import 'package:either_dart/either.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import '../../../../../../core/errors/failures.dart';

abstract class GetFavoriteOrderDetailsRepo {
  Future<Either<Failures, List<OrderEntity>>> getFavoriteOrdersDetails(List<String> orderIds);
}
