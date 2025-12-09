import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/views/widgets/favourite_orders_view_body.dart';

import '../../../../../../../../config/l10n/app_localizations.dart';

class FavouriteOrdersView extends StatelessWidget {
  const FavouriteOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: () async {

        Navigator.pushNamedAndRemoveUntil(context, RoutesManager.freelancerHome, (route) => false);

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,

          title: Text(
            "الطلبات المفضله",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: Colors.grey.shade300, height: 1.0),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(
                context, RoutesManager.freelancerHome, (route) => false),
            child: const Icon(CupertinoIcons.back ),
          ),
        ),

        body: const SafeArea(child: FavouriteOrdersViewBody()),
      ),
    );
  }
}
