import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/helper/convert_to_days.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import 'package:taskly/features/freelancer/presentation/views/freelancer_home_view.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/shared/presentation/views/widgets/description_section.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../../../../core/components/dismissible_error_card.dart';
import '../../view_model/freelancer_private_orders_view_model/freelancer_private_orders_view_model.dart';
import '../../view_model/send_offer_view_model/send_offer_view_model.dart';
import '../../view_model/send_offer_view_model/send_offer_view_model_states.dart';
import '../../view_model/get_commission_view_model/get_commission_view_model.dart';
import '../../view_model/get_commission_view_model/get_commission_sates.dart';
import 'input_proposal_price.dart';
import 'input_with_drop_down.dart';
import '../../../../../../../../../config/l10n/app_localizations.dart';

class SendOfferViewBody extends StatefulWidget {
  final OrderEntity orderEntity;
  const SendOfferViewBody({super.key, required this.orderEntity});

  @override
  State<SendOfferViewBody> createState() => _SendOfferViewBodyState();
}

class _SendOfferViewBodyState extends State<SendOfferViewBody> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController deliveryTimeController = TextEditingController();


  String selectedTimeUnit = "";

  final _formKey = GlobalKey<FormState>();

  String? descriptionError;
  String? priceError;
  String? deliveryTimeError;

  late GetCommissionViewModel commissionViewModel;

  @override
  void initState() {
    super.initState();
    commissionViewModel = context.read<GetCommissionViewModel>();
    commissionViewModel.getCommission();
  }

  double getPriceAfterCommission() {
    if (priceController.text.isEmpty) return 0;
    final price = double.tryParse(priceController.text) ?? 0;
    return commissionViewModel.calculatePriceAfterCommission(price);
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final List<String> timeUnits = [
      local.hours, // "ساعات" بالعربي أو "Hours" بالإنجليزي
      local.days,  // "أيام" أو "Days"
      local.weeks, // "أسابيع" أو "Weeks"
    ];
    if (selectedTimeUnit.isEmpty) {
      selectedTimeUnit = local.days; // الافتراضي "أيام" أو "Days"
    }
    String selectedCurrency =   local.sar;
    return BlocConsumer<SendOfferViewModel, SendOfferViewModelStates>(
      listener: (context, state) {
        if (state is SendOfferViewModelSuccess) {
          showTemporaryMessage(
            context,
            local.offer_sent_success,
            MessageType.success,
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const FreelancerHomeView(initialIndex: 1),
            ),
                (_) => false,
          );
        }
        if (state is SendOfferViewModelError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.h),
                            _buildSectionTitle(context, local.project_details),
                            SizedBox(height: 16.h),

                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 2.w,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                                color: ColorsManager.primary.withOpacity(.4),
                              ),
                              child: Text(
                                widget.orderEntity.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),

                            DescriptionSection(
                              description: widget.orderEntity.description,
                            ),
                            SizedBox(height: 16.h),
                            const Divider(thickness: 1, color: Colors.grey),
                            SizedBox(height: 16.h),

                            _buildSectionTitle(
                              context,
                              local.proposal_description,
                            ),
                            SizedBox(height: 8.h),
                            _buildDescriptionBox(context),
                            SizedBox(height: 16.h),
                            const Divider(thickness: 1, color: Colors.grey),
                            SizedBox(height: 16.h),

                            _buildSectionTitle(context, local.proposal_price),
                            SizedBox(height: 8.h),
                            InputProposalPrice(
                              hint: local.enter_price_hint,
                              controller: priceController,
                              selectedValue: selectedCurrency,
                              errorText: priceError,
                              onChanged: (val) {
                                setState(() {
                                  selectedCurrency = val!;
                                  if (priceError != null &&
                                      priceController.text.isNotEmpty) {
                                    priceError = null;
                                  }
                                });
                              },
                            ),

                            SizedBox(height: 8.h),
                            BlocBuilder<GetCommissionViewModel,
                                GetCommissionSates>(
                              builder: (context, commissionState) {
                                if (commissionState
                                is GetCommissionSatesLoading) {
                                  return const SizedBox();
                                }
                                if (commissionState
                                is GetCommissionSatesSuccess) {
                                  final priceAfter = getPriceAfterCommission();
                                  return Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      color: ColorsManager.primary
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                   child: Text(
                                  "${local.price_after_commission} ${priceAfter.toStringAsFixed(2)} ${local.sar}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorsManager.primary,
                                ),
                                ),


                                  );
                                }
                                return const SizedBox();
                              },
                            ),

                            SizedBox(height: 16.h),
                            const Divider(thickness: 1, color: Colors.grey),
                            SizedBox(height: 16.h),

                            _buildSectionTitle(context, local.delivery_time),
                            SizedBox(height: 8.h),
                            InputWithDropdown(
                              hint: local.enter_time_hint,
                              controller: deliveryTimeController,
                              selectedValue: selectedTimeUnit,
                              items: timeUnits,
                              errorText: deliveryTimeError,
                              onNumberChanged: (val) {},
                              onUnitChanged: (val) {
                                setState(() {
                                  selectedTimeUnit = val!;
                                });
                              },
                            ),

                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    ),

                    CustomButton(
                      title: local.send_offer_title,
                      ontap: () {
                        setState(() {
                          descriptionError = descriptionController.text.isEmpty
                              ? local.description_error
                              : null;
                          priceError = priceController.text.isEmpty
                              ? local.price_error
                              : null;
                          deliveryTimeError =
                          deliveryTimeController.text.isEmpty
                              ? local.delivery_time_error
                              : null;
                        });

                        if (descriptionError == null &&
                            priceError == null &&
                            deliveryTimeError == null) {
                          final offerId = const Uuid().v4();
                          final now = DateTime.now();
                          final deliveryTime =
                          int.parse(deliveryTimeController.text);
                          final deliveryTimeInDays = convertToMinutes(
                            deliveryTime,
                            selectedTimeUnit,
                          );
                          context.read<FreelancerPrivateOrdersViewModel>().markOrderAsOffered(widget.orderEntity.id);
                          context.read<SendOfferViewModel>().sendOffer(
                            OfferEntity(
                              id: offerId,
                              freelancerId:
                              SharedPrefHelper.getString(
                                  StringsManager.idKey)!,
                              clientId: widget.orderEntity.clientId,
                              orderId: widget.orderEntity.id,
                              offerAmount:
                              double.parse(priceController.text),
                              offerStatus: "pending",
                              offerDescription: descriptionController.text,
                              offerDeliveryTime: deliveryTimeInDays,
                              createdAt: now,
                              updatedAt: now,
                              orderName: widget.orderEntity.title,
                            ),
                          );
                        }
                      },
                    ),

                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),

            if (state is SendOfferViewModelLoading)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                  child: LoadingAnimationWidget.inkDrop(
                    size: 50.sp,
                    color: ColorsManager.primary,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        color: Colors.black,
      ),
    );
  }

  Widget _buildDescriptionBox(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 2.w),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: descriptionController,
          maxLines: 100,
          minLines: 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: local.offer_description_hint,
            errorText: descriptionError,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          onChanged: (val) {
            if (descriptionError != null && val.isNotEmpty) {
              setState(() {
                descriptionError = null;
              });
            }
          },
        ),
      ),
    );
  }
}
