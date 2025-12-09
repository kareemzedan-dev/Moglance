import 'package:flutter/material.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
import 'package:taskly/core/helper/get_local_services.dart';

class ClientHomeViewModel extends ChangeNotifier {
  List services = [];
  List filteredServices = [];
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  void loadServices(BuildContext context) {
    if (_isLoaded) return;

    final local = AppLocalizations.of(context)!;
    services = getLocalServices(local);
    filteredServices = List.from(services);
    _isLoaded = true;
    notifyListeners();
  }

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      filteredServices = List.from(services);
    } else {
      filteredServices = services
          .where((service) =>
      service.title.toLowerCase().contains(query.toLowerCase()) ||
          service.key.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
