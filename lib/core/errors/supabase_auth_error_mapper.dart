class SupabaseAuthErrorMapper {
  static const Map<String, String> _exact = {
    "User already registered": "هذا الحساب مسجّل بالفعل.",
    "Invalid login credentials": "بيانات تسجيل الدخول غير صحيحة.",
    "Password should be at least 6 characters":
        "كلمة المرور يجب أن تكون 6 أحرف على الأقل.",
    "Email rate limit exceeded": "محاولات كثيرة على هذا البريد. حاول لاحقًا.",
    "Unable to validate email address": "البريد الإلكتروني غير صالح.",
    "Confirmation email has already been sent":
        "تم إرسال رسالة التأكيد بالفعل.",
    "Invalid refresh token": "جلسة منتهية. سجّل الدخول مرة أخرى.",
    "Email not confirmed": "يرجى تأكيد بريدك الإلكتروني أولاً.",
    "Email link is invalid or has expired": "رابط التأكيد منتهي أو غير صالح.",
  };

  static const Map<String, String> _contains = {
    "already registered": "هذا الحساب مسجّل بالفعل.",
    "invalid email": "البريد الإلكتروني غير صالح.",
    "invalid login": "بيانات تسجيل الدخول غير صحيحة.",
    "invalid password": "كلمة المرور غير صحيحة.",
    "rate limit": "محاولات كثيرة، حاول لاحقًا.",
    "no such user": "هذا الحساب غير موجود.",
    "user not found": "هذا الحساب غير موجود.",
    "password should": "كلمة المرور ضعيفة، اجعلها أطول.",
    "connection refused": "لا يوجد اتصال بالخادم. افحص اتصال الإنترنت.",
    "timeout": "انتهى وقت الاتصال. حاول مرة أخرى.",
    "duplicate key value": "قيمة مكررة موجودة بالفعل.",
    "email not confirmed": "يرجى تأكيد بريدك الإلكتروني أولاً.",
    "expired": "انتهت الصلاحية، حاول مرة أخرى.",
    "refresh token": "جلسة منتهية. سجّل الدخول مرة أخرى.",
    "network error": "خطأ في الشبكة. تحقق من اتصالك.",
    "server error": "خطأ في الخادم. حاول لاحقًا.",
    "too many requests": "طلبات كثيرة جدًا. انتظر قليلاً.",
  };

  static const Map<String, String> _supabaseAuthCodes = {
    "invalid_credentials": "بيانات تسجيل الدخول غير صحيحة.",
    "email_not_confirmed": "يرجى تأكيد بريدك الإلكتروني أولاً.",
    "weak_password": "كلمة المرور ضعيفة جداً.",
    "user_already_exists": "هذا الحساب مسجّل بالفعل.",
    "user_not_found": "هذا الحساب غير موجود.",
    "email_rate_limit_exceeded": "محاولات كثيرة على هذا البريد. حاول لاحقًا.",
  };

  static const String _defaultMsg = "حدث خطأ غير متوقع، حاول مرة أخرى.";

  /// تحويل رسالة الخطأ إلى رسالة مفهومة للمستخدم
  static String parse(dynamic error) {
    final msg = _extractMessage(error).trim();
    final lowerMsg = msg.toLowerCase();

    if (msg.isEmpty) return _defaultMsg;

    // 1. البحث عن تطابق تام
    for (final key in _exact.keys) {
      if (lowerMsg == key.toLowerCase()) return _exact[key]!;
    }

    // 2. البحث في الحقول الجزئية
    for (final pattern in _contains.keys) {
      if (lowerMsg.contains(pattern.toLowerCase())) {
        return _contains[pattern]!;
      }
    }

    // 3. فحص أكواد خطأ Supabase المحددة
    final errorCode = _extractErrorCode(error);
    if (errorCode.isNotEmpty && _supabaseAuthCodes.containsKey(errorCode)) {
      return _supabaseAuthCodes[errorCode]!;
    }

    // 4. محاولة استخراج من JSON
    final jsonMsg = _tryExtractFromJson(error);
    if (jsonMsg.isNotEmpty) {
      final lowerJson = jsonMsg.toLowerCase();

      // البحث في JSON المستخرج
      for (final key in _exact.keys) {
        if (lowerJson == key.toLowerCase()) return _exact[key]!;
      }

      for (final pattern in _contains.keys) {
        if (lowerJson.contains(pattern.toLowerCase())) {
          return _contains[pattern]!;
        }
      }
    }

    // 5. إذا كانت الرسالة قصيرة، عرضها (محددة الطول)
    if (msg.length <= 100) {
      return _capitalizeFirst(msg);
    }

    return _defaultMsg;
  }

  /// استخراج رسالة الخطأ من أنواع مختلفة من المدخلات
  static String _extractMessage(dynamic error) {
    if (error == null) return "";

    // إذا كان نصاً عادياً
    if (error is String) return error.trim();

    // إذا كان كائن خطأ (Exception)
    if (error is Exception) {
      final msg = error.toString();
      if (msg.isNotEmpty) return msg.trim();
    }

    // إذا كان Map
    if (error is Map<String, dynamic> || error is Map) {
      // البحث في الحقول الشائعة
      final commonKeys = [
        'message',
        'msg',
        'error',
        'description',
        'details',
        'hint',
      ];

      for (final key in commonKeys) {
        if (error.containsKey(key) && error[key] != null) {
          final value = error[key];
          if (value is String) return value.trim();
          if (value is Map || value is Iterable) {
            final nested = _extractMessage(value);
            if (nested.isNotEmpty) return nested;
          }
        }
      }

      // البحث في جميع القيم
      for (final value in error.values) {
        if (value is String && value.trim().isNotEmpty) {
          return value.trim();
        }
      }
    }

    // إذا كان Iterable
    if (error is Iterable) {
      for (final item in error) {
        if (item is String && item.isNotEmpty) {
          return item.trim();
        }
        if (item is Map || item is Iterable) {
          final extracted = _extractMessage(item);
          if (extracted.isNotEmpty) return extracted;
        }
      }
    }

    // المحاولة الأخيرة
    try {
      final msg = error.toString();
      if (msg.isNotEmpty && msg != "Instance of '${error.runtimeType}'") {
        return msg.trim();
      }
    } catch (_) {}

    return "";
  }

  /// استخراج كود الخطأ من كائن Supabase
  static String _extractErrorCode(dynamic error) {
    if (error is Map) {
      final codeKeys = ['code', 'error_code', 'statusCode'];
      for (final key in codeKeys) {
        if (error.containsKey(key) && error[key] is String) {
          return error[key].toString().trim();
        }
      }
    }
    return "";
  }

  /// محاولة استخراج رسالة من JSON
  static String _tryExtractFromJson(dynamic error) {
    try {
      final raw = error is String ? error : error.toString();

      // أنماط مختلفة لاستخراج الرسالة من JSON
      final patterns = [
        // نمط JSON القياسي: "message": "text"
        RegExp(r'"message"\s*:\s*"([^"]+)"', caseSensitive: false),
        // نمط آخر: 'message': 'text'
        RegExp(r"'message'\s*:\s*'([^']+)'", caseSensitive: false),
        // نمط بدون علامات تنصيص
        RegExp(r'message\s*:\s*([^,}\n]+)', caseSensitive: false),
        // نمط error في JSON
        RegExp(r'"error"\s*:\s*"([^"]+)"', caseSensitive: false),
      ];

      for (final pattern in patterns) {
        final match = pattern.firstMatch(raw);
        if (match != null && match.groupCount >= 1) {
          String extracted = match.group(1) ?? "";
          extracted = extracted.replaceAll(RegExp(r'["\}]'), '').trim();
          if (extracted.isNotEmpty) return extracted;
        }
      }
    } catch (_) {}

    return "";
  }

  /// جعل الحرف الأول كبير (للرسائل القصيرة)
  static String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// دالة مساعدة للاستخدام مع try/catch
  static String handleError(dynamic error, [StackTrace? stackTrace]) {
    // يمكنك إضافة تسجيل الأخطاء هنا إذا أردت
    // logError(error, stackTrace);

    return parse(error);
  }
}

// استخدام متقدم مع تسجيل الأخطاء (اختياري)
/*
class ErrorLogger {
  static void logError(dynamic error, StackTrace? stackTrace) {
    // يمكنك إرسال الأخطاء إلى خدمة مثل Sentry, Firebase Crashlytics
    debugPrint('Error: $error');
    debugPrint('Stack: $stackTrace');
  }
}
*/
