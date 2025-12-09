import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/message_entity.dart';

abstract class SendToAdminMessagesRemoteDataSource {
  Future<Either<Failures, void>> SendToAdminMessage({required MessageEntity message});
}