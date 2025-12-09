import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/messages/domain/repositories/messages_repos/get_accepted_order_message_repo/get_accepted_order_message_repo.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../features/shared/domain/entities/order_entity/order_entity.dart';
import '../../../../welcome/presentation/cubit/welcome_states.dart';

@injectable
class GetAcceptedOrderMessagesUseCase {
  final GetAcceptedOrderMessageRepo repository;

  GetAcceptedOrderMessagesUseCase(this.repository);

  Future<Either<Failures, List<OrderEntity>>> call(String userId,{UserRole? role}) {
    return repository.getAcceptedOrderMessages(userId, role: role);
  }

  Stream<List<OrderEntity>> subscribeToAcceptedOrders(String userId,{UserRole? role}) {
    return repository.subscribeToAcceptedOrders(userId, role: role);
  }
}
