import 'package:flutter/widgets.dart';
import 'package:taskly/core/services/supabase_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserStatusService {
  final SupabaseService supabaseService;
  late final String _userId;
  bool _initialized = false;

  UserStatusService(this.supabaseService);

  // ✅ دي اللي هناديها من Taskly علشان نبدأ التتبع
  void initialize(String userId) {
    if (_initialized) return;
    _initialized = true;
    _userId = userId;
    WidgetsBinding.instance.addObserver(_LifecycleHandler(this));
    _updateUserStatus(true); // أول ما التطبيق يفتح
  }

  Future<void> _updateUserStatus(bool online) async {
    try {
      final response = await supabaseService.supabaseClient
          .from('users')
          .update({
        'is_online': online,
        'last_seen': DateTime.now().toUtc().toIso8601String(),
      })
          .eq('id', _userId)
          .select();

      print('✅ User status updated: $response');
    } catch (e) {
      print('❌ Error updating user status: $e');
    }
  }

  void handleAppLifecycle(AppLifecycleState state) {
    if (!_initialized) return;
    if (state == AppLifecycleState.resumed) {
      _updateUserStatus(true);
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      _updateUserStatus(false);
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(_LifecycleHandler(this));
    if (_initialized) {
      _updateUserStatus(false);
    }
  }
}

// ✅ كلاس بسيط لمراقبة حالة التطبيق
class _LifecycleHandler extends WidgetsBindingObserver {
  final UserStatusService service;
  _LifecycleHandler(this.service);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    service.handleAppLifecycle(state);
  }
}
