// chat/presentation/cubit/chat_avatars_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/profile/presentation/manager/profile_view_model/profile_view_model.dart';
import 'chat_avatars_state.dart';
@injectable
class ChatAvatarsCubit extends Cubit<ChatAvatarsState> {
  final ProfileViewModel profileVm;

  ChatAvatarsCubit(this.profileVm) : super(ChatAvatarsLoading());

  Future<void> loadAvatars(String currentUserId, String receiverId) async {
    try {
      final results = await Future.wait([
        profileVm.fetchUserInfo(currentUserId, "freelancer"),
        profileVm.fetchUserInfo(receiverId, "client"),
      ]);
      emit(ChatAvatarsLoaded(
        freelancerAvatar: results[0]?.profileImage,
        clientAvatar: results[1]?.profileImage,
      ));
    } catch (e) {
      emit(ChatAvatarsError(e.toString()));
    }
  }
}
