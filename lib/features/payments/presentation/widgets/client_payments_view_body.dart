import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/components/confirmation_dialog.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/core/components/dismissible_error_card.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/features/attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model.dart';
import 'package:taskly/features/attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model_states.dart';
import 'package:taskly/features/attachments/presentation/manager/upload_order_attachments_view_model/upload_order_attachments_states.dart';
import 'package:taskly/features/client/presentation/views/client_home_view.dart';
import 'package:taskly/features/payments/domain/entities/payment_entity.dart';
import 'package:taskly/features/payments/presentation/manager/create_payment_view_model/create_payment_view_model.dart';
import 'package:taskly/features/payments/presentation/manager/create_payment_view_model/create_payment_view_model_states.dart';
import 'package:taskly/features/payments/presentation/widgets/payments_content.dart';
import 'package:taskly/features/payments/presentation/widgets/upload_payment_proof_button.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/l10n/app_localizations.dart';
import '../../../attachments/presentation/manager/upload_order_attachments_view_model/upload_order_attachments_view_model.dart';
import '../../../shared/domain/entities/order_entity/order_entity.dart';

class ClientPaymentsViewBody extends StatelessWidget {
  final OrderEntity order;
  ClientPaymentsViewBody({required this.order});

  final Uuid uuid = Uuid();

  Future<bool> _onWillPop(BuildContext context) async {
    final local = AppLocalizations.of(context)!;
    final uploadVM = context.read<UploadOrderAttachmentsViewModel>();

    if (uploadVM.uploadedAttachments.isNotEmpty) {
      bool shouldLeave = false;

      await showConfirmationDialog(
        context: context,
        title: local.warning,
        message: local.leave_warning_message,
        confirmText: local.leave,
        cancelText: local.stay,
        onConfirm: () => shouldLeave = true,
        onCancel: () => shouldLeave = false,
      );

      return shouldLeave;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final uploadVM = context.read<UploadOrderAttachmentsViewModel>();

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(

        appBar: AppBar(
          surfaceTintColor: Colors.white,


          elevation: 0,
          title: Text(
            local.payments,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 1.h),
            child: Divider(
              thickness: 1,
              color: Colors.grey.shade300,
            ),
          ),
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back, ),
            onPressed: () async {
              final canPop = await _onWillPop(context);
              if (canPop) Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.h),
            child: Column(
              children: [
                const Expanded(child: PaymentsContent()),
                const UploadAttachmentsSection(),
                SizedBox(height: 16.h),
                BlocListener<CreatePaymentViewModel,
                    CreatePaymentViewModelStates>(
                  listener: (context, state) {
                    if (state is CreatePaymentViewModelStatesLoading) {
                      showTemporaryMessage(
                          context, local.creating_payment, MessageType.waiting);
                    } else if (state is CreatePaymentViewModelStatesError) {
                      showTemporaryMessage(
                          context, state.message, MessageType.error);
                    } else if (state is CreatePaymentViewModelStatesSuccess) {
                      showTemporaryMessage(context,
                          local.payment_created_success, MessageType.success);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                            const ClientHomeView(initialIndex: 1)),
                            (route) => false,
                      );
                    }
                  },
                  child: CustomButton(
                    title: local.make_payment,
                    ontap: () {
                      if (uploadVM.files.isNotEmpty &&
                          uploadVM.files.length !=
                              uploadVM.uploadedFileHashes.length) {
                        return showTemporaryMessage(context, local.wait_uploads,
                            MessageType.error);
                      }
                      if (uploadVM.uploadedAttachments.isEmpty) {
                        return showTemporaryMessage(context,
                            local.upload_payment_proof_first, MessageType.error);
                      }

                      final paymentId = uuid.v4();
                      context.read<CreatePaymentViewModel>().createPayment(
                        PaymentEntity(
                          id: paymentId,
                          clientId: order.clientId,
                          freelancerId: order.freelancerId,
                          orderId: order.id,
                          attachments: uploadVM.uploadedAttachments,
                          amount: order.budget!,
                          status: "Pending",
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                          paymentMethod: "",
                          accountNumber: "",
                          requesterType: "client",
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UploadAttachmentsSection extends StatelessWidget {
  const UploadAttachmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocBuilder<UploadOrderAttachmentsViewModel,
        UploadOrderAttachmentsViewModelStates>(
      builder: (context, state) {
        if (state is UploadOrderAttachmentsViewModelStatesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is UploadOrderAttachmentsViewModelStatesError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showTemporaryMessage(context, state.message, MessageType.error);
          });
        }
        if (state is UploadOrderAttachmentsViewModelStatesSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showTemporaryMessage(context, local.payment_proof_uploaded_success,
                MessageType.success);
          });
        }
        return UploadPaymentProofButton(
          onTap: () {
            context.read<UploadOrderAttachmentsViewModel>().pickFilesFromDevice(
              bucketName: "payment_attachments",
            );
          },
        );
      },
    );
  }
}
