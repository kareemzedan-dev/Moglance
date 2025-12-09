
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/services/supabase_service.dart';
import 'package:taskly/core/utils/network_utils.dart';
import 'package:taskly/features/client/domain/entities/home/service_response_entity.dart';
import 'package:taskly/features/profile/data/models/user_info_dm/user_info_response_dm.dart';
import 'package:taskly/features/profile/domain/entities/user_info_entity/user_info_entity.dart';
import 'package:taskly/features/shared/data/models/order_dm/order_dm.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/client/data/data_sources/remote/home_remote_data_source.dart';
import 'package:taskly/features/client/data/models/home/service_response_dm.dart';
 

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
 
  SupabaseService supabaseService  ;

  HomeRemoteDataSourceImpl({required this.supabaseService});
 

  @override
  Future<Either<Failures, List<ServiceEntity>>> getServices() async {
    try {
      var result = await Connectivity().checkConnectivity();
  if(NetworkUtils.hasInternet() == false) {
    return const Left(NetworkFailure('No internet connection'));
  }
        final response = await supabaseService.getDataFromSupabase(
          tableName: "services",
        );

        if (response == null || response.isEmpty) {
          return const Left(ServerFailure("Services not found"));
        }

        final services = response.map((e) => ServiceDm.fromJson(e)).toList();

        return Right(services);
     
    } catch (e) {
      return Left(ServerFailure("Failed to fetch services: $e"));
    }
  }

  @override
  Future<Either<Failures, OrderDm>> placeOrder(OrderEntity orderEntity) async {
    try {
      var result = await Connectivity().checkConnectivity();
  if(NetworkUtils.hasInternet() == false) {
    return const Left(NetworkFailure('No internet connection'));
  }
        final orderDm = OrderDm.fromEntity(orderEntity);

        final response = await supabaseService.sendDataToSupabase(
          tableName: "orders",
          data: orderDm.toJson(),
        );
        var order = OrderDm.fromJson(response!);
        return Right(order);
    
    } catch (e) {
      return Left(ServerFailure("Failed to place order: $e"));
    }
  }

  @override
  Future<Either<Failures, List<UserInfoEntity>>>
  getAllFreelancerInfo() async {
    try {
      var result = await Connectivity().checkConnectivity();
  if(!await NetworkUtils.hasInternet() ) {
    return const Left(NetworkFailure('No internet connection'));
  }

        final userResponse = await supabaseService.getDataFromSupabase(
          tableName: "users",
          filters: {"role": "freelancer"},
        );

        if (userResponse == null || userResponse.isEmpty) {
          return const Left(ServerFailure("No freelancers found"));
        }


      List<UserInfoEntity> freelancers = [];
      for (final userData in userResponse) {
        final freelancerResponse = await supabaseService.getDataFromSupabase(
          tableName: "freelancers",
          filters: {"id": userData['id']},
        );

        final freelancerData =
        freelancerResponse != null && freelancerResponse.isNotEmpty
            ? freelancerResponse.first
            : null;

        final freelancer = UserInfoDm.fromJson(userData);

        final mergedFreelancer = freelancer.copyWith(
          rating: (freelancerData?['rating'] as num?)?.toDouble() ?? 0.0,
          hourlyRate: (freelancerData?['hourly_rate'] as num?)?.toDouble(),
          skills: freelancerData?['skills'] != null
              ? List<String>.from(freelancerData!['skills'])
              : [],
        );

        freelancers.add(mergedFreelancer);
      }
// ترتيب حسب الـrating من الأعلى للأقل مع التعامل مع null
      freelancers.sort((a, b) {
        final ratingA = a.rating ?? 0.0;
        final ratingB = b.rating ?? 0.0;
        return ratingB.compareTo(ratingA);
      });

      return Right(freelancers);


    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }



 

}
