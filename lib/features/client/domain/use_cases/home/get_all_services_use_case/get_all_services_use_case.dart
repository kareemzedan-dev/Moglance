import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/client/domain/entities/home/service_response_entity.dart';
import 'package:taskly/features/client/domain/repos/home/home_repos.dart';
@injectable
class GetAllServicesUseCase {
  final HomeRepos homeRepos;
  GetAllServicesUseCase(this.homeRepos);
    Future<Either<Failures,List<ServiceEntity>>> callServices() => homeRepos.getServices();
 
}