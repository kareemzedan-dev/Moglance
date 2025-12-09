import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/message_entity.dart';

abstract class GetAdminMessagesRepo {
  Future<Either<Failures,List<MessageEntity>>> getAdminMessages(String currentUserId);
}