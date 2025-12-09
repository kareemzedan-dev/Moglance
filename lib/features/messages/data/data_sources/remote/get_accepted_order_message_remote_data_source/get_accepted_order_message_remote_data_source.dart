import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/welcome/presentation/cubit/welcome_states.dart';

abstract class GetAcceptedOrderMessageRemoteDataSource {
    Future<Either<Failures, List<OrderEntity>>> getAcceptedOrderMessages(String userId,{UserRole? role});

    Stream<List<OrderEntity>> subscribeToAcceptedOrders(String userId,{UserRole? role});

}