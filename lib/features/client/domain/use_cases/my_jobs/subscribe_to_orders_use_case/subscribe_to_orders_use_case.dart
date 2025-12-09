import 'package:injectable/injectable.dart';

import '../../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../../repos/my_jobs/my_jobs_repo.dart';

@injectable
class SubscribetToOrdersUseCase {
  final MyJobsRepo myJobsRepo;
  SubscribetToOrdersUseCase(this.myJobsRepo);

   Stream<(OrderEntity, String)> subscribeToOrders(Map<String, String> filters,
    ){
  return    myJobsRepo.subscribeToOrders(filters);
  }

}