import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/message_entity.dart';

abstract class GetAdminMessagesRemoteDataSource {
  Future<Either<Failures,List<MessageEntity>>> getAdminMessages(String currentUserId);
}