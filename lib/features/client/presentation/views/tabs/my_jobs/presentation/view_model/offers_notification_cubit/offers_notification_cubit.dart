import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

class OffersNotificationCubit extends Cubit<bool> {
  OffersNotificationCubit() : super(false);

  void newOfferArrived() => emit(true);

  void clearNotification() => emit(false);
}
