import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/view_model/place_order_view_model/place_order_view_model.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/widgets/category_drop_down.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/widgets/description_box.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/widgets/hiring_methods_options.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/widgets/private_hire_section.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/widgets/time_input_raw.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/widgets/attachments_files_section.dart';
import 'package:taskly/features/profile/presentation/manager/profile_view_model/profile_view_model.dart';
import '../../../../../../../../attachments/presentation/manager/upload_order_attachments_view_model/upload_order_attachments_view_model.dart';
import '../../../../../../../../attachments/presentation/manager/upload_order_attachments_view_model/upload_order_attachments_states.dart';
import '../../../../../../../../profile/presentation/manager/profile_view_model/profile_view_model_states.dart';
import '../../../../../../../../../core/components/custom_text_field.dart';

class OrderFormSection extends StatefulWidget {
  final int selectedHireMethodIndex;
  final ValueChanged<int> onHireMethodChanged;
  final VoidCallback onSubmit;

  const OrderFormSection({
    super.key,
    required this.selectedHireMethodIndex,
    required this.onHireMethodChanged,
    required this.onSubmit,
  });

  @override
  State<OrderFormSection> createState() => _OrderFormSectionState();
}



class _OrderFormSectionState extends State<OrderFormSection> {

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final viewModel = context.read<PlaceOrderViewModel>();

    final profileVM = context.watch<ProfileViewModel>();
    final uploadVM = context.watch<UploadOrderAttachmentsViewModel>();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _buildLabel(context, local.title_label),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) return "ادخل العنوان";
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  hintText: "ادخل العنوان",
                  textEditingController: viewModel.titleController,
                ),
                SizedBox(height: 28.h),
                _buildLabel(context, local.category_label),
                SizedBox(height: 16.h),
                CategoryDropDown(selectedCategory: viewModel.selectedCategory ?? ''),
                SizedBox(height: 28.h),
                _buildLabel(context, local.description_label),
                SizedBox(height: 16.h),
                const DescriptionBox(),
                SizedBox(height: 28.h),
                _buildLabel(context, local.deadline_label),
                SizedBox(height: 16.h),
                const TimeInputRaw(),
                SizedBox(height: 28.h),
                _buildLabel(context, local.attachments_label),
                SizedBox(height: 16.h),
                AttachmentsFilesSection(uploadOrderAttachmentsViewModel: uploadVM),
                SizedBox(height: 28.h),
                _buildLabel(context, local.hiring_method_label),
                SizedBox(height: 16.h),
                HiringMethodsOptions(
                  selectedIndex: widget.selectedHireMethodIndex,
                  onChanged: widget.onHireMethodChanged,
                ),
                if (widget.selectedHireMethodIndex == 1)
                  PrivateHireSection(selectedId: viewModel.freelancerId),
                SizedBox(height: 28.h),


              ],
            ),
          ),
        ),
        // زر الإرسال
        BlocBuilder<ProfileViewModel, ProfileViewModelStates>(
          builder: (context, profileState) {
            final isActive = profileState is ProfileViewModelStatesSuccess &&
                profileState.userInfoEntity.clientStatus == "Active";

            return BlocBuilder<UploadOrderAttachmentsViewModel,
                UploadOrderAttachmentsViewModelStates>(
              builder: (context, uploadState) {
                final isUploading =
                uploadState is UploadOrderAttachmentsViewModelStatesLoading;

                return CustomButton(
                  title:
                  isUploading ? "جاري رفع الملفات..." : local.submit_button,
                  ontap: isUploading ? null : widget.onSubmit,
                  isEnable: !isUploading,
                );
              },
            );
          },
        ),
        SizedBox(height: 28.h),
      ],
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
    );
  }
}
