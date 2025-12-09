import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/client/domain/use_cases/home/place_order_use_case/place_order_use_case.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/view_model/place_order_view_model/place_order_view_model_states.dart';
import 'package:uuid/uuid.dart';
import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../../core/di/di.dart';
import '../../../../../../../../attachments/data/models/attachments_dm/attachments_dm.dart';
import '../../../../../../../../attachments/presentation/manager/upload_order_attachments_view_model/upload_order_attachments_view_model.dart';
import 'place_order_validator.dart';

@injectable
class PlaceOrderViewModel extends Cubit<PlaceOrderViewModelStates> {
  final PlaceOrderUseCase _placeOrderUseCase;


  PlaceOrderViewModel(this._placeOrderUseCase)
      : super(PlaceOrderViewModelStatesInitial());

  /// ------------------------
  /// Controllers & Data
  /// ------------------------
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();


  final String orderId = const Uuid().v4();
  final String? clientId = SharedPrefHelper.getString("id");

  final UploadOrderAttachmentsViewModel uploadOrderAttachmentsViewModel =
  getIt<UploadOrderAttachmentsViewModel>();

  String? selectedCategory;
  String? freelancerId;
  String selectedTimeUnit = "";
  List<String> timeUnits = [];

  final List<File> localAttachments = [];
  final List<AttachmentModel> uploadedAttachments = [];
  final Map<String, double> uploadProgress = {};

  /// Hiring method: 0 = public, 1 = private
  int hireMethodIndex = 0;

  /// ------------------------
  /// Initialization
  /// ------------------------
  void initializeOrder({
    required String title,
    required String category,
    required List<String> timeUnits,
  }) {
    titleController.text = title;
    selectedCategory = category;
    this.timeUnits = timeUnits;
    selectedTimeUnit = timeUnits.first;

    emit(PlaceOrderViewModelStatesInitial());
  }


  /// ------------------------
  /// Set freelancer
  /// ------------------------
  void setFreelancer(String id) {
    freelancerId = id;
    emit(PlaceOrderViewModelFreelancerSelected(id));
  }

  /// ------------------------
  /// Set hiring method
  /// ------------------------
  void setHireMethod(int index) {
    hireMethodIndex = index;
    emit(PlaceOrderViewModelHiringMethodChanged(index));
  }

  /// ------------------------
  /// Calculate deadline
  /// ------------------------
  DateTime? calculateDeadline(String timeValue, String selectedUnit) {
    final parsedValue = int.tryParse(timeValue);
    if (parsedValue == null) return null;

    switch (selectedUnit) {
      case 'Hours':
      case 'ساعات':
        return DateTime.now().add(Duration(hours: parsedValue));
      case 'Days':
      case 'أيام':
        return DateTime.now().add(Duration(days: parsedValue));
      case 'Weeks':
      case 'أسابيع':
        return DateTime.now().add(Duration(days: parsedValue * 7));
      default:
        return null;
    }
  }
  void setUploadedAttachments(List<AttachmentModel> attachments) {
    uploadedAttachments.clear();
    uploadedAttachments.addAll(attachments);
  }


  /// ------------------------
  /// Submit Order
  /// ------------------------
  Future<void> submitOrder() async {
    emit(PlaceOrderViewModelStatesLoading());

    // Validate
    final validator = PlaceOrderValidator(this);
    final String? validationError = validator.validate(hireMethodIndex);

    if (validationError != null) {
      emit(PlaceOrderViewModelStatesError(validationError));
      return;
    }

    final orderEntity = validator.buildOrderEntity(hireMethodIndex);
    final result = await _placeOrderUseCase.callPlaceOrder(orderEntity);



    result.fold(
          (failure) => emit(PlaceOrderViewModelStatesError(failure.message)),
          (order) => emit(PlaceOrderViewModelStatesSuccess(order)),
    );
  }

}
