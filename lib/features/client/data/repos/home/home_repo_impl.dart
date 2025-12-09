
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/client/domain/entities/home/service_response_entity.dart';
import 'package:taskly/features/client/domain/repos/home/home_repos.dart';
import 'package:taskly/features/profile/domain/entities/user_info_entity/user_info_entity.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/client/data/data_sources/remote/home_remote_data_source.dart';
 
@Injectable(as: HomeRepos)
class HomeRepoImpl extends HomeRepos {
  HomeRemoteDataSource homeremoteDataSource;

  HomeRepoImpl({required this.homeremoteDataSource});
 

  @override
  Future<Either<Failures, List<ServiceEntity>>> getServices() {
    return homeremoteDataSource.getServices();
  }

  @override
  Future<Either<Failures, OrderEntity>> placeOrder(OrderEntity orderEntity) {
    return homeremoteDataSource.placeOrder(orderEntity);
  }

  @override
  Future<Either<Failures, List<UserInfoEntity>>> getAllFreelancer() {
    return homeremoteDataSource.getAllFreelancerInfo();
    
  }

 
}
