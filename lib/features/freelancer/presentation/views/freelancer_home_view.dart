import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/assets_manager.dart';
import 'package:taskly/core/components/custom_bottom_navigation_bar.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/views/find_work_tab_view.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/my_jobs/presentation/views/my_jobs_tab_view.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/profile/presentation/views/profile_view.dart';
import 'package:taskly/features/messages/presentation/pages/user_messages_tab_view.dart';

import '../../../../config/l10n/app_localizations.dart';

class FreelancerHomeView extends StatefulWidget {
    final int initialIndex;
  const FreelancerHomeView({super.key,  this.initialIndex = 0});

  @override
  State<FreelancerHomeView> createState() => _FreelancerHomeView();
}

class _FreelancerHomeView extends State<FreelancerHomeView> {
  late int currentIndex;

  List<Widget> items = [
   const FreelancerHomeTabView(),
  const FreelancerMyJobsTabView(),
   const UserMessagesTabView(),
   const FreelancerProfileViewTab(),
 
  ];
  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    
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
          child: CustomBottomNavigationBar(
        firstTabName: local.find_work,
        firstTabicon: Assets.assetsImagesWork,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
          ),
    );
  }
}
