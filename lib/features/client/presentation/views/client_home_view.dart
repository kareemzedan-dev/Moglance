import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskly/core/components/custom_bottom_navigation_bar.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/view_model/client_home_view_model/client_home_view_model.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/home_tab_view.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/client_orders_subscription_cubit/client_orders_subscription_cubit.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/offers_notification_cubit/offers_notification_cubit.dart';
import 'package:taskly/features/messages/presentation/pages/user_messages_tab_view.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/views/my_jobs_tab_view.dart';
import 'package:taskly/features/client/presentation/views/tabs/profile/presentation/views/profile_view.dart';

import '../../../../core/cache/shared_preferences.dart';
import '../../../../core/utils/strings_manager.dart';

class ClientHomeView extends StatefulWidget {
  final int initialIndex;
  const ClientHomeView({super.key, this.initialIndex = 0});

  @override
  State<ClientHomeView> createState() => _ClientHomeViewState();
}
class _ClientHomeViewState extends State<ClientHomeView> {
  late int currentIndex;
  late final List<Widget> items;

  final userId = SharedPrefHelper.getString(StringsManager.idKey);

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    if (userId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<ClientOrdersSubscriptionCubit>().init(userId!);
      });

    }
    items = [
      ChangeNotifierProvider(
        create: (_) => ClientHomeViewModel(),
        child: const HomeTabView(),
      ),
      MyJobsTabView(),
      const UserMessagesTabView(),
      const ClientProfileViewTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(child: items[currentIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300,
              width: 1.w,
            ),
          ),
        ),
        child: BlocBuilder<OffersNotificationCubit, bool>(
          builder: (context, hasJobUpdates) {
            return CustomBottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() => currentIndex = index);

                if (index == 1) {
                  context.read<OffersNotificationCubit>().clearNotification();
                }
              },
              hasJobUpdates: hasJobUpdates,
            );
          },
        )

      ),

    );
  }
}
