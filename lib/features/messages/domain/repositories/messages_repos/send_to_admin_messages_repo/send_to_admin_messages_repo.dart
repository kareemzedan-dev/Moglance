import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';

import '../../../entities/message_entity.dart';

abstract class SendToAdminMessagesRepo {
  Future<Either<Failures,void>> SendToAdminMessage({required MessageEntity message});
}