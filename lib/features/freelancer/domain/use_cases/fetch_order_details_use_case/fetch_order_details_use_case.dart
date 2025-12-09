import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../repos/offer_repository/offer_repository.dart';
@injectable
class FetchOrderDetailsUseCase {
  final OfferRepository offerRepository;
  FetchOrderDetailsUseCase(this.offerRepository);
  Future<Either<Failures, OrderEntity>> call(String orderId ) => offerRepository.fetchOrderDetails(orderId);
}