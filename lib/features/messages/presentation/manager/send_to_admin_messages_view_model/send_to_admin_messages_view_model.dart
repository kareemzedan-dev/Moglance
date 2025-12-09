import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/messages/domain/use_cases/send_to_admin_messages_use_case/send_to_admin_messages_use_case.dart';
import 'package:taskly/features/messages/presentation/manager/send_to_admin_messages_view_model/send_to_admin_messages_states.dart';

import '../../../domain/entities/message_entity.dart';
@injectable
class SendToAdminMessagesViewModel extends Cubit<SendToAdminMessagesStates>{
  final SendToAdminMessagesUseCase sendToAdminMessagesUseCase;
  SendToAdminMessagesViewModel(this.sendToAdminMessagesUseCase): super(SendToAdminMessagesInitial());


Future<void> SendToAdminMessage({required MessageEntity message}) async {
  try{
    emit(SendToAdminMessagesLoadingState());
  final result =  await sendToAdminMessagesUseCase.SendToAdminMessage(message: message);
  result.fold(
    (failure) => emit(SendToAdminMessagesErrorState( failure.message)),
    (_) => emit(SendToAdminMessagesSuccessState("Message sent successfully")),

  );


  }
  catch (e, stackTrace){
    print("SendToAdmin Error: $e");
    print(stackTrace);
    emit(SendToAdminMessagesErrorState(e.toString()));
  }

}
}