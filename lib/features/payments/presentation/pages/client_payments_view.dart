import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/l10n/app_localizations.dart';
import '../../../attachments/presentation/manager/upload_order_attachments_view_model/upload_order_attachments_view_model.dart';
import '../../../shared/domain/entities/order_entity/order_entity.dart';
import '../widgets/client_payments_view_body.dart';
import '../../../attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/features/payments/presentation/manager/create_payment_view_model/create_payment_view_model.dart';

class ClientPaymentsView extends StatelessWidget {
  const ClientPaymentsView({super.key, required this.order});
  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<UploadOrderAttachmentsViewModel>()),
        BlocProvider(create: (_) => getIt<CreatePaymentViewModel>()),
      ],
      child: WillPopScope(
        onWillPop: () => _onWillPop(context, local),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ClientPaymentsViewBody(order: order),
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context, AppLocalizations local) async {
    final uploadVM = context.read<UploadOrderAttachmentsViewModel>();

    if (uploadVM.uploadedAttachments.isNotEmpty) {
      final shouldLeave = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(local.warning),
          content: Text(
            local.upload_warning_message,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(local.stay),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(local.leave),
            ),
          ],
        ),
      );
      return shouldLeave ?? false;
    }
    return true;
  }
}
