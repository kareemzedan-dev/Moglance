import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/views/widgets/send_offer_view_body.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../../../../../../../config/l10n/app_localizations.dart';
import '../view_model/freelancer_private_orders_view_model/freelancer_private_orders_view_model.dart';
import '../view_model/get_commission_view_model/get_commission_view_model.dart';
import '../view_model/send_offer_view_model/send_offer_view_model.dart';

class SendOfferView extends StatelessWidget {
    SendOfferView({super.key,required this.orderEntity});
  OrderEntity orderEntity  ;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          local.send_offer,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back, color: Colors.black),
        ),
      ),
      body:   MultiBlocProvider(providers: [
        BlocProvider(create:   (context) => getIt<SendOfferViewModel>(),),
        BlocProvider(create:   (context) => getIt<GetCommissionViewModel>(),),
     BlocProvider(create:   (context) => getIt<FreelancerPrivateOrdersViewModel>(),),
      ], child:  SendOfferViewBody(orderEntity: orderEntity))

    );
  }
}
