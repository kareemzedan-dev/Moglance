class MessageValidationService {
  // Regex patterns
  final RegExp _phoneRegex = RegExp(r'(\+201[0-9]{9}|01[0-9]{9}|[0-9]{8,})');
  final RegExp _urlRegex = RegExp(r'(https?:\/\/|www\.|facebook\.com|wa\.me|whatsapp\.com)');
  final RegExp _emailRegex = RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');

  /// Returns null if message is valid, otherwise returns warning string
  String? validate(String content) {
    if (_phoneRegex.hasMatch(content)) {
      return "🚫 Sending phone numbers is not allowed";
    }
    if (_urlRegex.hasMatch(content)) {
      return "🚫 Sending links is not allowed";
    }
    if (_emailRegex.hasMatch(content)) {
      return "🚫 Sending emails is not allowed";
    }
    return null; // message is valid
  }
}
