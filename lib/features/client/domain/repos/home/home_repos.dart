

import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/client/domain/entities/home/service_response_entity.dart';
import 'package:taskly/features/profile/domain/entities/user_info_entity/user_info_entity.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
 

abstract class HomeRepos {
 
  Future<Either<Failures,List<ServiceEntity>>> getServices();
  Future<Either<Failures,OrderEntity>> placeOrder(OrderEntity orderEntity);
  Future<Either<Failures, List<UserInfoEntity>>> getAllFreelancer();
 
}