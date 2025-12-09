

 import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../domain/use_cases/is_order_favorite_use_case/is_order_favorite_repo.dart';
import 'is_order_favorite_states.dart';
@injectable
class  IsOrderFavoriteViewModel extends Cubit<IsOrderFavoriteStates> {
  IsOrderFavoriteUseCase isOrderFavoriteUseCase;
  IsOrderFavoriteViewModel(this.isOrderFavoriteUseCase) : super(IsOrderFavoriteInitial());

  Future<Either<Failures, bool>> isOrderFavorite(String userId, String orderId) async {
    try{
     emit(IsOrderFavoriteLoadingState());
     final result = await isOrderFavoriteUseCase(userId, orderId);
     result.fold((failure) => emit(IsOrderFavoriteErrorState(failure)),
             (isFavorite) => emit(IsOrderFavoriteSuccessState(isFavorite)));
     return result;
    }
    catch(e){
     emit(IsOrderFavoriteErrorState(Failures(e.toString())));
     return Left(Failures(e.toString()));
    }
  }

}