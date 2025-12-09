import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/core/components/custom_text_field.dart';
import 'package:taskly/core/components/dismissible_error_card.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/freelancer/domain/entities/earings_entity/earings_entity.dart';
import 'package:taskly/features/freelancer/presentation/cubit/get_total_earnings_view_model/get_total_earnings_states.dart';
import 'package:taskly/features/freelancer/presentation/cubit/get_total_earnings_view_model/get_total_earnings_view_model.dart';
import 'package:taskly/features/freelancer/presentation/cubit/place_withdrawal_balance_view_model/place_withdrawal_balance_states.dart';
import 'package:taskly/features/freelancer/presentation/cubit/place_withdrawal_balance_view_model/place_withdrawal_balance_view_model.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/profile/presentation/views/widgets/wallet_card.dart';
import 'package:taskly/features/payments/domain/entities/payment_entity.dart';
import 'package:uuid/uuid.dart';

class WithdrawalRequestTabContent extends StatefulWidget {
  const WithdrawalRequestTabContent({super.key});

  @override
  State<WithdrawalRequestTabContent> createState() =>
      _WithdrawalRequestTabContentState();
}

class _WithdrawalRequestTabContentState
    extends State<WithdrawalRequestTabContent> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? selectedMethod;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocConsumer<PlaceWithdrawalBalanceViewModel,
        PlaceWithdrawalBalanceStates>(
      listener: (context, state) {
        if (!context.mounted) return;

        if (state is PlaceWithdrawalBalanceSuccessState) {
          showTemporaryMessage(
            context,
            local.withdrawalRequestPlacedSuccessfully,
            MessageType.success,
          );

          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

        } else if (state is PlaceWithdrawalBalanceErrorState) {

          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },

      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Wallet Card Section
                BlocBuilder<GetTotalEarningsViewModel, GetTotalEarningsStates>(
                  builder: (context, state) {
                    if (state is GetTotalEarningsLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetTotalEarningsSuccessState) {
                      return WalletCardSection(earnings: state.earningsEntity);
                    } else if (state is GetTotalEarningsErrorState) {
                      return Center(child: Text(local.errorFetchingEarnings));
                    }
                    return const WalletCardSectionIntital();
                  },
                ),
                SizedBox(height: 20.h),

                // Amount Input
                AmountInputSection(controller: amountController),
                SizedBox(height: 20.h),

                // Payment Method
                PaymentMethodSection(
                  selectedMethod: selectedMethod,
                  onMethodChanged: (value) {
                    setState(() {
                      selectedMethod = value;
                    });
                  },
                ),
                SizedBox(height: 20.h),

                // Mobile Number
                MobileNumberSection(controller: phoneController),
                SizedBox(height: 30.h),

                // Submit Button
                SubmitButtonSection(
                  onTap: () {
                    final amount =
                    double.tryParse(amountController.text.trim());
                    final phone = phoneController.text.trim();

                    final earningsState =
                        context.read<GetTotalEarningsViewModel>().state;
                    double availableBalance = 0;
                    if (earningsState is GetTotalEarningsSuccessState) {
                      availableBalance = earningsState.earningsEntity.balance;
                    }

                    if (amount == null || amount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(local.enterValidAmount)),
                      );
                      return;
                    }

                    if (amount > availableBalance) {
                      showTemporaryMessage(
                        context,
                        local.cannotWithdrawMoreThanBalance(availableBalance.toString()),
                        MessageType.error,
                      );

                      return;
                    }

                    if (phone.isEmpty || selectedMethod == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(local.selectMethodAndEnterPhone)),
                      );
                      return;
                    }

                    context
                        .read<PlaceWithdrawalBalanceViewModel>()
                        .placeWithdrawalBalance(
                      PaymentEntity.forFreelancer(
                        id: Uuid().v4(),
                        freelancerId: SharedPrefHelper.getString(
                            StringsManager.idKey),
                        amount: amount,
                        accountNumber: phone,
                        paymentMethod: selectedMethod,
                        status: "pending",
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                    );
                  },
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// ========================== WIDGETS ==========================

class WalletCardSection extends StatelessWidget {
  const WalletCardSection({super.key, required this.earnings});

  final EarningsEntity earnings;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return WalletCard(
        availableBalance: "${earnings.balance} ${local.sar}",
        totalEarnings: "${earnings.totalEarnings} ${local.sar}",
        withdrawn: "${earnings.totalEarnings - earnings.balance} ${local.sar}");
  }
}

class WalletCardSectionIntital extends StatelessWidget {
  const WalletCardSectionIntital({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return WalletCard(
        availableBalance: "0 ${local.sar}",
        totalEarnings: "0 ${local.sar}",
        withdrawn: "0 ${local.sar}");
  }
}

class AmountInputSection extends StatelessWidget {
  final TextEditingController controller;

  const AmountInputSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              local.withdrawalAmount,
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextFormField(
              textEditingController: controller,
              hintText: local.enterAmount,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodSection extends StatelessWidget {
  final String? selectedMethod;
  final ValueChanged<String?> onMethodChanged;

  const PaymentMethodSection({
    super.key,
    required this.selectedMethod,
    required this.onMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              local.selectPaymentMethod,
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 8.h),
            _buildMethodOption(
              context,
              method: "Vodafone Cash",
              icon: Icons.account_balance_wallet_outlined,
              color: Colors.red,
              title: local.vodafoneCash,
            ),
            _buildMethodOption(
              context,
              method: "InstaPay",
              icon: Icons.account_balance,
              color: Colors.blue,
              title: local.instapay,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodOption(
      BuildContext context, {
        required String method,
        required IconData icon,
        required Color color,
        required String title,
      }) {
    return GestureDetector(
      onTap: () => onMethodChanged(method),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedMethod == method
                ? ColorsManager.primary
                : Colors.grey.shade300,
            width: selectedMethod == method ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: RadioListTile<String>(
          value: method,
          groupValue: selectedMethod,
          activeColor: ColorsManager.primary,
          onChanged: onMethodChanged,
          title: Row(
            children: [
              Icon(icon, color: color),
              SizedBox(width: 8.w),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileNumberSection extends StatelessWidget {
  final TextEditingController controller;

  const MobileNumberSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              local.mobileNumber,
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.phone_android,
                  color: ColorsManager.primary,
                ),
                hintText: local.enterMobileNumber,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: ColorsManager.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              local.vodafoneCashNote,
              style: textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubmitButtonSection extends StatelessWidget {
  final VoidCallback onTap;

  const SubmitButtonSection({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final local =AppLocalizations.of(context)!;
    return CustomButton(title: local.submitRequest, ontap: onTap);
  }
}