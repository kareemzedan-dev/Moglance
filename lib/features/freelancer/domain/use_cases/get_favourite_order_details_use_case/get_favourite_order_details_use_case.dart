import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import '../../../../../../core/errors/failures.dart';
import '../../repos/favorite_order_repos/get_favourite_order_details_repo/get_favourite_order_details.dart';
@injectable
 class GetFavoriteOrderDetailsUseCase {
   final GetFavoriteOrderDetailsRepo getFavoriteOrderDetailsRepo;
   GetFavoriteOrderDetailsUseCase(this.getFavoriteOrderDetailsRepo);
   Future<Either<Failures, List<OrderEntity>>> call(List<String> orderIds) {
     return getFavoriteOrderDetailsRepo.getFavoriteOrdersDetails(orderIds);
   }
 }
