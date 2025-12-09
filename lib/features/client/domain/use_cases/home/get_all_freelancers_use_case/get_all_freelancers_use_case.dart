import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/client/domain/repos/home/home_repos.dart';
import 'package:taskly/features/profile/domain/entities/user_info_entity/user_info_entity.dart';
@injectable
class GetAllFreelancersUseCase {
  final HomeRepos homeRepository;
  GetAllFreelancersUseCase(this.homeRepository);
    Future<Either<Failures, List<UserInfoEntity>>> callGetFreelancer() => homeRepository.getAllFreelancer();
 
}