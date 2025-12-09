

 import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../domain/entities/favorite_order_entity/favorite_order_entity.dart';
import '../../../../../../../domain/use_cases/get_favorite_order_use_case/get_favorite_order_repo.dart';
import 'get_favorite_order_states.dart';
@injectable
class GetFavoriteOrderViewModel extends Cubit<GetFavoriteOrderStates> {
  GetFavoriteOrderUseCase getFavoriteOrderUseCase;
  GetFavoriteOrderViewModel(this.getFavoriteOrderUseCase) : super(GetFavoriteOrderInitial());

  Future<Either<Failures, List<FavoriteOrderEntity>>> getFavoritesByUser(String userId) async {
    try{
      emit(GetFavoriteOrderLoadingState());
      final result = await getFavoriteOrderUseCase(userId);
      result.fold((failure) => emit(GetFavoriteOrderErrorState(failure)), (favorites) => emit(GetFavoriteOrderSuccessState(favorites)));
      return result;
    }
    catch(e){
      emit(GetFavoriteOrderErrorState(ServerFailure(e.toString())));
      return Left(ServerFailure(e.toString()));
    }
  }
}