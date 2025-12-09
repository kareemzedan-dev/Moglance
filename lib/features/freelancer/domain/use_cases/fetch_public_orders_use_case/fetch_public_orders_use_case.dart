import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../repos/freelancer_order_repo/fetch_public_orders_repo/fetch_public_orders_repo.dart';

@injectable
class FetchPublicOrdersUseCase {
  final FetchPublicOrdersRepo fetchPublicOrdersRepo;

  FetchPublicOrdersUseCase({required this.fetchPublicOrdersRepo});

  Future<Either<Failures, List<OrderEntity>>> fetchPublicOrders(String freelancerId) =>
      fetchPublicOrdersRepo.fetchPublicOrders(freelancerId);



}
