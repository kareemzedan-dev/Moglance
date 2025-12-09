
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';
import 'package:taskly/features/messages/domain/repositories/messages_repos/send_to_admin_messages_repo/send_to_admin_messages_repo.dart';

import '../../data_sources/remote/send_to_admin_messages_remote_data_source/send_to_admin_messages_remote_data_source.dart';
@Injectable(as:  SendToAdminMessagesRepo)
class SendToAdminMessagesRepoImpl implements SendToAdminMessagesRepo{
  final SendToAdminMessagesRemoteDataSource remoteDataSource;
  SendToAdminMessagesRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, void>> SendToAdminMessage({required MessageEntity message}) {
return remoteDataSource.SendToAdminMessage(message: message);
  }


}