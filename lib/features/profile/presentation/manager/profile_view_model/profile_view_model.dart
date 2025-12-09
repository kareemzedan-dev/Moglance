import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/profile/domain/use_cases/profile/profile_use_case.dart';
import 'package:taskly/features/profile/presentation/manager/profile_view_model/profile_view_model_states.dart';

import '../../../domain/entities/user_info_entity/user_info_entity.dart';
@injectable
class ProfileViewModel extends Cubit<ProfileViewModelStates> {
  ProfileViewModel(this.profileUseCase) : super(ProfileViewModelStatesInitial());

  final ProfileUseCase profileUseCase;

  // Cache لكل المستخدمين
  final Map<String, UserInfoEntity> cachedUsers = {};

  Future<void> getUserInfo(String userId, String role) async {
    try {
      if (isClosed) return;

      // لو موجود في الكاش خلاص
      if (cachedUsers.containsKey(userId)) return;

      // ما نعملش emit Loading هنا، عشان prefetch مش يؤثر على UI
      final result = await profileUseCase.callUserInfo(userId, role);

      if (isClosed) return;

      result.fold(
            (l) => debugPrint("Error fetching user $userId: ${l.message}"), // بس debug
            (r) {
          cachedUsers[userId] = r; // خزّن في الكاش
          emit(ProfileViewModelStatesSuccess(r)); // emit بس للـ last fetched
        },
      );
    } catch (e) {
      if (isClosed) return;
      debugPrint("Exception fetching user $userId: $e");
    }
  }

  UserInfoEntity? getUserFromCache(String userId) => cachedUsers[userId];

  Future<UserInfoEntity?> fetchUserInfo(String userId, String role) async {
    final result = await profileUseCase.callUserInfo(userId, role);
    return result.fold(
          (l) {
        debugPrint("Error fetching user $userId: ${l.message}");
        return null;
      },
          (r) {
        cachedUsers[userId] = r;
        emit(ProfileViewModelStatesCacheUpdated());

        return r;
      },
    );
  }
  Future<UserInfoEntity> getUserInfoFuture(String userId, String role) async {
    final completer = Completer<UserInfoEntity>();

    final subscription = stream.listen((state) {
      if (state is ProfileViewModelStatesSuccess) {
        completer.complete(state.userInfoEntity);
      }
      if (state is ProfileViewModelStatesError) {
        completer.completeError(state.message);
      }
    });

    getUserInfo(userId, role);
    final result = await completer.future;
    subscription.cancel();
    return result;
  }


}
