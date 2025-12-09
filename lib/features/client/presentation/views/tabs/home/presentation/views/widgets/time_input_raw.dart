import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/view_model/place_order_view_model/place_order_view_model.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';

class TimeInputRaw extends StatefulWidget {
  const TimeInputRaw({super.key});

  @override
  State<TimeInputRaw> createState() => _TimeInputRawState();
}

class _TimeInputRawState extends State<TimeInputRaw> {
  late final PlaceOrderViewModel placeOrderViewModel;

  @override
  void initState() {
    super.initState();
    placeOrderViewModel = context.read<PlaceOrderViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: placeOrderViewModel.timeController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                style: TextStyle(  fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: local.enter_time,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
            const SizedBox(width: 8),
            DropdownButton<String>(
              style:  TextStyle( fontSize: 14.sp ,color: Colors.grey),
              value: placeOrderViewModel.selectedTimeUnit,
              items: placeOrderViewModel.timeUnits
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() {

                if (val != null) placeOrderViewModel.selectedTimeUnit = val;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
