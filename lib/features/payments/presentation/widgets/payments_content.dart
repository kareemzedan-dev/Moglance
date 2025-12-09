import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/attachments/presentation/manager/upload_order_attachments_view_model/upload_order_attachments_states.dart';
import 'package:taskly/features/payments/presentation/widgets/bank_details_card.dart';
import 'package:taskly/features/payments/presentation/widgets/call_center_icon.dart';
import 'package:taskly/features/payments/presentation/widgets/payment_note_card.dart';
import 'package:taskly/features/payments/presentation/widgets/secure_payment_bannar.dart';

import '../../../../core/di/di.dart';
import '../../../attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model.dart';
import '../../../attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model_states.dart';
import '../../../attachments/presentation/manager/upload_order_attachments_view_model/upload_order_attachments_view_model.dart';
import '../../../shared/presentation/views/widgets/attachments_section.dart';
import '../manager/get_bank_account_view_model/get_bank_account_view_model.dart';
import 'bank_details_card_list.dart';

class PaymentsContent extends StatelessWidget {
  const PaymentsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadOrderAttachmentsViewModel, UploadOrderAttachmentsViewModelStates>(
      builder: (context, state) {
        final attachments = context.read<UploadOrderAttachmentsViewModel>().uploadedAttachments;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SecurePaymentBanner(),
              SizedBox(height: 16.h),
              BlocProvider(
                  create:  (context) => getIt<GetBankAccountViewModel>()..listenToBankAccounts(),
                  child: BankDetailsCardList()),
              SizedBox(height: 40.h),
              Divider(thickness: 1, color: ColorsManager.primary.withOpacity(0.2)),
              SizedBox(height: 16.h),
              const CallCenterIcon(),
              SizedBox(height: 16.h),
              const PaymentNoteCard(),
              SizedBox(height: 16.h),
              AttachmentsSection(
                attachmentEntity: attachments,
                isFreelancer: false,
              ),
            ],
          ),
        );
      },
    );
  }
}
