import 'package:taskly/features/client/domain/repos/my_jobs/my_jobs_repo.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:injectable/injectable.dart';
@injectable
class SubscribeToOrderStatusUseCase {
   final MyJobsRepo myJobsRepo;

  SubscribeToOrderStatusUseCase(this.myJobsRepo);
  
   Stream<(OrderEntity, String)> subscribeToOrderStatus({
    required Map<String, String> filters,
 
  }) {
    return myJobsRepo.subscribeToOrders(filters,  );
  }
}