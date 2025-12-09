import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/repositories/messages_repos/get_admin_messages_repo/get_admin_messages_repo.dart';
import '../../data_sources/remote/get_admin_messages_remote_data_source/get_admin_messages_remote_data_source.dart';
@Injectable(as:  GetAdminMessagesRepo)
  class GetAdminMessagesRepoImpl implements GetAdminMessagesRepo{
    final GetAdminMessagesRemoteDataSource remoteDataSource;
    GetAdminMessagesRepoImpl(this.remoteDataSource);
    @override
    Future<Either<Failures,List<MessageEntity>>> getAdminMessages(String currentUserId) {
      return remoteDataSource.getAdminMessages(currentUserId);
    }
}