import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/assets_manager.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/payments/presentation/widgets/bank_info_raw.dart';
import '../../../../config/l10n/app_localizations.dart';
import '../../../../core/services/copy_to_clipboard.dart';
import '../../domain/entities/bank_accounts_entity/bank_accounts_entity.dart';

class BankDetailsCard extends StatelessWidget {
  const BankDetailsCard({super.key, required this.bankAccountsEntity});
  final BankAccountsEntity bankAccountsEntity;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Card(
      elevation: 6,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: ColorsManager.primary.withOpacity(0.2),
        ),
        child: Column(
          children: [
            // 1️⃣ اسم البنك
            BankInfoRow(
              label: local.bankName,
              number: bankAccountsEntity.bankName ?? "",
              assetPath: Assets.assetsImagesBankAccount,
              onCopy: () =>
                  copyToClipboard(context, bankAccountsEntity.bankName ?? ""),
            ),
            SizedBox(height: 16.h),
            Divider(thickness: 1, color: ColorsManager.primary.withOpacity(0.2)),
            SizedBox(height: 16.h),

            // 2️⃣ اسم الحساب
            BankInfoRow(
              label: local.account_name,
              number: bankAccountsEntity.accountName ?? "",
              assetPath: Assets.assetsImagesUser12366536,
              onCopy: () =>
                  copyToClipboard(context, bankAccountsEntity.accountName ?? ""),
            ),
            SizedBox(height: 16.h),
            Divider(thickness: 1, color: ColorsManager.primary.withOpacity(0.2)),
            SizedBox(height: 16.h),

            // 3️⃣ رقم الحساب
            BankInfoRow(
              label: local.account_number,
              number: bankAccountsEntity.accountNumber ?? "",
              assetPath: Assets.assetsImagesAccountNumber,
              onCopy: () =>
                  copyToClipboard(context, bankAccountsEntity.accountNumber ?? ""),
            ),
            SizedBox(height: 16.h),
            Divider(thickness: 1, color: ColorsManager.primary.withOpacity(0.2)),
            SizedBox(height: 16.h),

            // 4️⃣ الايبان
            BankInfoRow(
              label: local.iban_number,
              number: bankAccountsEntity.iban ?? "",
              assetPath: Assets.assetsImagesBankAccount,
              onCopy: () =>
                  copyToClipboard(context, bankAccountsEntity.iban ?? ""),
            ),
            SizedBox(height: 16.h),
            Divider(thickness: 1, color: ColorsManager.primary.withOpacity(0.2)),
            SizedBox(height: 16.h),

            // 5️⃣ رمز سويفت
            BankInfoRow(
              label: local.swift_code,
              number: bankAccountsEntity.swiftCode ?? "",
              assetPath: Assets.assetsImagesSwiftCode,
              onCopy: () =>
                  copyToClipboard(context, bankAccountsEntity.swiftCode ?? ""),
            ),
            SizedBox(height: 16.h),
            Divider(thickness: 1, color: ColorsManager.primary.withOpacity(0.2)),
            SizedBox(height: 16.h),

            // 6️⃣ ملاحظات
            BankInfoRow(
              label: local.notes,
              number: bankAccountsEntity.notes ?? "",
              assetPath: Assets.assetsImagesDocument10103871,
              onCopy: () =>
                  copyToClipboard(context, bankAccountsEntity.notes ?? ""),
            ),
          ],
        ),
      ),
    );
  }
}
