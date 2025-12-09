

 import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/view_model/remove_favorite_order_view_model/remove_favorite_order_states.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../domain/use_cases/remove_favorite_order_use_case/remove_favorite_order_repo.dart';
@injectable
class RemoveFavoriteOrderViewModel extends Cubit<RemoveFavoriteOrderStates> {
  RemoveFavoriteOrderUseCase removeFavoriteOrderUseCase;
  RemoveFavoriteOrderViewModel(this.removeFavoriteOrderUseCase) : super(RemoveFavoriteOrderInitial());

Future<Either<Failures, void>> removeFavoriteOrder(String id) async {
  try{
    emit(RemoveFavoriteOrderLoadingState());
    final result = await removeFavoriteOrderUseCase(id);
    result.fold((failure) => emit(RemoveFavoriteOrderErrorState(failure)), (success) => emit(RemoveFavoriteOrderSuccessState()));
    return result;

  }
  catch(e){
    emit(RemoveFavoriteOrderErrorState(Failures(e.toString())));
    return Left(ServerFailure(e.toString()));
  }
}
}