import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputWithDropdown extends StatelessWidget {
  final String hint;
  final String selectedValue;
  final List<String> items;
  final ValueChanged<String?> onUnitChanged; // ✅ للوحدة (Days/Hours/Weeks)
  final ValueChanged<String>? onNumberChanged; // ✅ للرقم (2 أو 5 أو غيره)
  final TextEditingController? controller;
  final String? errorText;

  const InputWithDropdown({
    super.key,
    required this.hint,
    required this.selectedValue,
    required this.items,
    required this.onUnitChanged,
    this.onNumberChanged,
    required this.controller,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2.w,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: onNumberChanged, // ✅ ده للرقم فقط
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                errorText: errorText,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          DropdownButton2<String>(
            value: selectedValue, // ✅ يفضل يبقى Hours/Days/Weeks
            underline: const SizedBox(),
            isExpanded: false,
            items: items
                .map((val) => DropdownMenuItem(
                      value: val,
                      child: Text(val),
                    ))
                .toList(),
            onChanged: onUnitChanged, // ✅ ده للوحدة فقط
            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 40.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade200,
              ),
            ),
            menuItemStyleData: MenuItemStyleData(height: 40.h),
          ),
        ],
      ),
    );
  }
}
