import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/use_cases/get_admin_messages_use_case/get_admin_messages_use_case.dart';
import 'get_admin_messages_states.dart';
import '../../../../../core/errors/failures.dart';

@injectable
class GetAdminMessagesViewModel extends Cubit<GetAdminMessagesStates> {
  final GetAdminMessagesUseCase getAdminMessagesUseCase;

  GetAdminMessagesViewModel(this.getAdminMessagesUseCase)
      : super(GetAdminMessagesInitial());

  void getAdminMessages(String currentUserId) async {
    emit(GetAdminMessagesLoadingState());

    try {
      final result = await getAdminMessagesUseCase.getAdminMessages(currentUserId);

      result.fold(
            (failure) {
          emit(GetAdminMessagesErrorState(failure));
        },
            (messages) {
          emit(GetAdminMessagesSuccessState( messages));
        },
      );
    } catch (e) {
      emit(GetAdminMessagesErrorState(ServerFailure(e.toString())));
    }
  }
}
