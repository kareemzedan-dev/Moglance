import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/view_model/place_order_view_model/place_order_view_model.dart';

import '../../../../../../../../attachments/data/models/attachments_dm/attachments_dm.dart';

class PlaceOrderValidator {
  final PlaceOrderViewModel vm;

  PlaceOrderValidator(this.vm);

  /// ------------------------
  /// ✅ Validate inputs
  /// ------------------------
  String? validate(int hireMethodIndex) {
    if (vm.titleController.text.trim().isEmpty) {
      return 'الرجاء إدخال عنوان الطلب';
    }
    if (vm.selectedCategory == null || vm.selectedCategory!.isEmpty) {
      return 'الرجاء اختيار فئة الطلب';
    }
    if (vm.descriptionController.text.trim().isEmpty) {
      return 'الرجاء إدخال وصف الطلب';
    }
    if (vm.timeController.text.trim().isEmpty) {
      return 'الرجاء تحديد الوقت المطلوب للتسليم';
    }

    if (vm.localAttachments.isNotEmpty &&
        vm.uploadedAttachments.length != vm.localAttachments.length) {
      return 'انتظر حتى يتم رفع جميع المرفقات';
    }

    if (hireMethodIndex == 1 &&
        (vm.freelancerId == null || vm.freelancerId!.isEmpty)) {
      return 'الرجاء اختيار المستقل للطلب الخاص';
    }

    return null;
  }

  /// ------------------------
  /// 🧩 Build OrderEntity
  /// ------------------------
  OrderEntity buildOrderEntity(int hireMethodIndex) {
    return OrderEntity(
      id: vm.orderId,
      clientId: vm.clientId!,
      freelancerId: hireMethodIndex == 1 ? vm.freelancerId : null,
      title: vm.titleController.text.trim(),
      description: vm.descriptionController.text.trim(),
      category: vm.selectedCategory!,
      attachments: vm.uploadedAttachments.map((file) => AttachmentModel(
        size: file.size,
        storagePath: file.storagePath,
        id: file.id,
        url: file.url,
        name: file.name,
        type: file.type,
      )).toList(), // ✅ هنا نضيف المرفقات أثناء الإنشاء
      serviceType: hireMethodIndex == 1 ? ServiceType.private : ServiceType.public,
      status: OrderStatus.Pending,
      deadline: vm.calculateDeadline(vm.timeController.text, vm.selectedTimeUnit),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      offersCount: 0,
      offerId: null,
    );
  }

}
