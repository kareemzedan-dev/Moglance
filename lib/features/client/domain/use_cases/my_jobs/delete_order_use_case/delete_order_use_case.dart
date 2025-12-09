import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../repos/my_jobs/delete_order_repo/delete_order_repo.dart';
@injectable
class DeleteOrderUseCase {
  final DeleteOrderRepo deleteOrderRepo;
  DeleteOrderUseCase(this.deleteOrderRepo);
  Future<Either<Failures, void>> call(String orderId) async {
    return await deleteOrderRepo.deleteOrder(orderId);
  }
}