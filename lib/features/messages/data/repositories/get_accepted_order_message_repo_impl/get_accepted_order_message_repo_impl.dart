import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/messages/data/data_sources/remote/get_accepted_order_message_remote_data_source/get_accepted_order_message_remote_data_source.dart';
import 'package:taskly/features/messages/domain/repositories/messages_repos/get_accepted_order_message_repo/get_accepted_order_message_repo.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/welcome/presentation/cubit/welcome_states.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:  GetAcceptedOrderMessageRepo)
  class GetAcceptedOrderMessageRepoImpl implements GetAcceptedOrderMessageRepo{
    GetAcceptedOrderMessageRemoteDataSource getAcceptedOrderMessageRemoteDataSource;

    GetAcceptedOrderMessageRepoImpl({required this.getAcceptedOrderMessageRemoteDataSource});
    @override
    Future<Either<Failures, List<OrderEntity>>> getAcceptedOrderMessages(String userId,{UserRole? role}) async{
      return await getAcceptedOrderMessageRemoteDataSource.getAcceptedOrderMessages(userId,role: role);
    }
    @override
    Stream<List<OrderEntity>> subscribeToAcceptedOrders(String userId,{UserRole? role}) {
      return getAcceptedOrderMessageRemoteDataSource.subscribeToAcceptedOrders(userId,role: role);
    }
  

}