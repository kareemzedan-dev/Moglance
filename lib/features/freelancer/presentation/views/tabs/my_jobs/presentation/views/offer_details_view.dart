import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/my_jobs/presentation/views/widgets/offer_details_view_body.dart';

import '../../../../../../../../config/l10n/app_localizations.dart';

class OfferDetailsView extends StatelessWidget {
  const OfferDetailsView({super.key,required this.orderId});
 final String orderId;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return  Scaffold(

      appBar: AppBar(

        elevation: 0,
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
        title: Text(
          local.orderDetails,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(CupertinoIcons.back )),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),

      ),
      body: OfferDetailsViewBody(orderId: orderId,),

    );
  }
}
