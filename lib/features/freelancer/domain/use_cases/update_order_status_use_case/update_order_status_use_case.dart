import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/freelancer/domain/repos/freelancer_order_repo/update_order_status_repo/update_order_status_repo.dart';
@injectable
class UpdateOrderStatusUseCase {
  UpdateOrderStatusRepo updateOrderStatusRepo ;

  UpdateOrderStatusUseCase(this.updateOrderStatusRepo);

  Future<Either<Failures, void>> call(String orderId , String status) => updateOrderStatusRepo.updateOrderStatus(orderId, status);

}