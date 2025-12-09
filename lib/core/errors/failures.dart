class Failures {
  final String message;
  final Map<String, String>? params;

  const Failures(this.message, [this.params]);
}

class ServerFailure extends Failures {
  const ServerFailure(String message, {Map<String, String>? params})
      : super(message, params);
}

class CacheFailure extends Failures {
  const CacheFailure(String message, {Map<String, String>? params})
      : super(message, params);
}

class NetworkFailure extends Failures {
  const NetworkFailure(String message, {Map<String, String>? params})
      : super(message, params);
}

class LocationFailure extends Failures {
  const LocationFailure(String message, {Map<String, String>? params})
      : super(message, params);
}

class PermissionFailure extends Failures {
  const PermissionFailure(String message, {Map<String, String>? params})
      : super(message, params);
}

class CameraFailure extends Failures {
  const CameraFailure(String message, {Map<String, String>? params})
      : super(message, params);
}

class AudioFailure extends Failures {
  const AudioFailure(String message, {Map<String, String>? params})
      : super(message, params);
}

class VideoFailure extends Failures {
  const VideoFailure(String message, {Map<String, String>? params})
      : super(message, params);
}

class OtherFailure extends Failures {
  const OtherFailure(String message, {Map<String, String>? params})
      : super(message, params);
}

class AuthFailure extends Failures {
  const AuthFailure(String message, {Map<String, String>? params})
      : super(message, params);

  @override
  String toString() => message;
}
