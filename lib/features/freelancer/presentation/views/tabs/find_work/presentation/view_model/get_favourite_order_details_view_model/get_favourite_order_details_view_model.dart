import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/freelancer/domain/use_cases/get_favourite_order_details_use_case/get_favourite_order_details_use_case.dart';

import '../../../../../../../../../core/errors/failures.dart';
import '../../../../../../../../shared/domain/entities/order_entity/order_entity.dart';
import 'get_favourite_order_details_states.dart';
@injectable
class GetFavouriteOrderDetailsViewModel
    extends Cubit<GetFavouriteOrderDetailsStates> {
  final GetFavoriteOrderDetailsUseCase getFavoriteOrderDetailsUseCase;

  GetFavouriteOrderDetailsViewModel(this.getFavoriteOrderDetailsUseCase)
      : super(GetFavouriteOrderDetailsInitial());

  Future<Either<Failures, List<OrderEntity>>> getFavouriteOrderDetails(
      List<String> orderIds) async {
    try {
      emit(GetFavouriteOrderDetailsLoadingState());
      final result = await getFavoriteOrderDetailsUseCase.call(orderIds);
      result.fold((failure) =>
          emit(GetFavouriteOrderDetailsErrorState(failure.message)), (orders) =>
          emit(GetFavouriteOrderDetailsSuccessState(orders)));
      return result;
    }
    catch(e){
      emit(GetFavouriteOrderDetailsErrorState(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}