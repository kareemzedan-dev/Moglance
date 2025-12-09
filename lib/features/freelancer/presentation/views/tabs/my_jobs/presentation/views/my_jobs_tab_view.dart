import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/components/custom_tab_bar.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/freelancer/presentation/cubit/get_freelancer_offers_view_model/get_freelancer_offers_states.dart';
import 'package:taskly/features/freelancer/presentation/cubit/get_freelancer_offers_view_model/get_freelancer_offers_view_model.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/my_jobs/presentation/views/widgets/my_jobs_tab_view_body.dart';
import '../../../../../../../../config/l10n/app_localizations.dart';
import 'package:taskly/core/di/di.dart';

class FreelancerMyJobsTabView extends StatefulWidget {
  const FreelancerMyJobsTabView({super.key});

  @override
  State<FreelancerMyJobsTabView> createState() => _FreelancerMyJobsTabViewState();
}


class _FreelancerMyJobsTabViewState extends State<FreelancerMyJobsTabView> {
  @override
  Widget build(BuildContext context) {



    final local = AppLocalizations.of(context)!;
    final viewModel = getIt<GetFreelancerOffersViewModel>();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          shape: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 2),
          ),
          title: Text(
            local.manageOrders,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),

          // 👇 نستخدم BlocBuilder عشان نحدث أرقام البادجز
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.h), // ارتفاع التاب بار
            child: BlocProvider(
              create: (context) {
                final vm = viewModel;
                final id = SharedPrefHelper.getString(StringsManager.idKey)!;
                vm.getFreelancerOffers(id); // أول مرة
                vm.listenToOffersChanges(id); // ✅ اشتراك لحظي
                return vm;
              },
              child: BlocBuilder<GetFreelancerOffersViewModel, GetFreelancerOffersStates>(

                builder: (context, state) {
                  Map<String, int> badgeCounts = {
                    "pending": 0,
                    "accepted": 0,
                    "completed": 0,
                    "rejected": 0,
                  };

                  if (state is GetFreelancerOffersSuccessState) {
                    print("🎯 Total offers: ${state.offers.length}");
                    for (var offer in state.offers) {
                      print("🧾 Offer ID: ${offer.id}, Status: ${offer.offerStatus}");

                      switch (offer.offerStatus) {
                        case "pending":
                          badgeCounts["pending"] = (badgeCounts["pending"] ?? 0) + 1;
                          break;
                        case "accepted":
                          badgeCounts["accepted"] = (badgeCounts["accepted"] ?? 0) + 1;
                          break;
                        case "completed":
                          badgeCounts["completed"] = (badgeCounts["completed"] ?? 0) + 1;
                          break;
                        case "rejected":
                          badgeCounts["rejected"] = (badgeCounts["rejected"] ?? 0) + 1;
                          break;
                      }
                    }
                  }



                  return CustomTabBar(
                    tabs: [
                      local.pending,
                      local.accepted,
                      local.completed,
                      local.rejected,
                    ],
                    numbers: [
                      badgeCounts["pending"] ?? 0,
                      badgeCounts["accepted"] ?? 0,
                      badgeCounts["completed"] ?? 0,
                      badgeCounts["rejected"] ?? 0,
                    ],
                  );
                },
              ),
            ),
          ),

        ),

        body: const MyJobsTabViewBody(),
      ),
    );
  }
}
