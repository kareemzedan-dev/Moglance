import 'package:taskly/config/l10n/app_localizations.dart';

extension AppLocalizationsX on AppLocalizations {
  String _mapRole(String role) {
    switch (role) {
      case "client":
        return client;
      case "freelancer":
        return freelancer;
      default:
        return role; // fallback
    }
  }

  String translate(String key, {Map<String, String>? params}) {
    switch (key) {
      case "noInternetConnection":
        return noInternetConnection;
      case "emailAlreadyExists":
        return emailAlreadyExists;
      case "somethingWentWrong":
        return somethingWentWrong;
      case "loginFailed":
        return loginFailed;
      case "notRegisteredAsRole":
        return notRegisteredAsRole(_mapRole(params?["role"] ?? ""));
      case "googleLoginCancelled":
        return googleLoginCancelled;
      case "accountAlreadyRegistered":
        return accountAlreadyRegistered(
          _mapRole(params?["existingRole"] ?? ""),
          _mapRole(params?["role"] ?? ""),
        );
      case "userRegisteredSuccessfully":
        return userRegisteredSuccessfully;
      case "userLoginSuccessfully":
        return userLoginSuccessfully;
      case "googleLoginSuccessful":
        return googleLoginSuccessful;
      default:
        return key;
    }
  }
}
