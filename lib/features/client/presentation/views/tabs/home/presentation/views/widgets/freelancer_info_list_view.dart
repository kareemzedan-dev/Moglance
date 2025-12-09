import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/assets_manager.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/view_model/fetch_all_freelancers_view_model/fetch_all_freelancers_view_model_states.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/widgets/freelancer_info_card_for_hire.dart';
import 'package:taskly/features/profile/presentation/manager/profile_view_model/profile_view_model.dart';

import '../../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../../../core/di/di.dart';
import '../../view_model/fetch_all_freelancers_view_model/fetch_all_freelancers_view_model.dart';
import '../../view_model/place_order_view_model/place_order_view_model.dart';

class FreelancerInfoListView extends StatefulWidget {
  const FreelancerInfoListView({super.key, required this.selectedId, this.searchQuery});
  final String? selectedId;
  final String? searchQuery;

  @override
  State<FreelancerInfoListView> createState() => _FreelancerInfoListViewState();
}

class _FreelancerInfoListViewState extends State<FreelancerInfoListView> {
  bool _isPrefetching = false;

  Future<void> _prefetchRatings(
      List<dynamic> freelancers, ProfileViewModel profileVM) async {
    if (_isPrefetching) return;
    _isPrefetching = true;

    for (final f in freelancers) {
      if (profileVM.getUserFromCache(f.id) == null) {
        await profileVM.fetchUserInfo(f.id, "freelancer");
        if (mounted) setState(() {}); 
      }
    }

    _isPrefetching = false;
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAllFreelancersViewModel,
        FetchAllFreelancersViewModelStates>(
      builder: (context, state) {
        if (state is FreelancersViewModelStatesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FreelancersViewModelStatesSuccess) {
          final profileVM = context.read<ProfileViewModel>();

          // Prefetch async لكل freelancers
          _prefetchRatings(state.freelancers, profileVM);

          // فلترة حسب البحث
          final filteredFreelancers = state.freelancers.where((f) {
            final query = widget.searchQuery?.toLowerCase() ?? '';
            final name = f.fullName?.toLowerCase() ?? '';
            return name.contains(query);
          }).toList();

          // ترتيب حسب الـ rating
          filteredFreelancers.sort((a, b) {
            final ratingA =
                profileVM.getUserFromCache(a.id)?.rating ?? a.rating ?? 0.0;
            final ratingB =
                profileVM.getUserFromCache(b.id)?.rating ?? b.rating ?? 0.0;
            return ratingB.compareTo(ratingA);
          });

          if (filteredFreelancers.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.assetsImagesempty,
                    height: 100.h,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "لا يوجد مستقلين بهذا الاسم",
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredFreelancers.length,
            itemBuilder: (context, index) {
              final freelancer = filteredFreelancers[index];
              final userRating =
                  profileVM.getUserFromCache(freelancer.id)?.rating ??
                      freelancer.rating ??
                      0.0;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: FreelancerInfoCardForHire(
                  userRating: userRating,
                  freelancer: freelancer,
                  isSelected: freelancer.id == widget.selectedId,
                  onReviewsTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.reviewsView,
                      arguments: {
                        'userId': freelancer.id,
                        "role": "freelancer",
                        "userName": freelancer.fullName,
                        "userImage": freelancer.profileImage,
                        "userRating": userRating,
                      },
                    );
                  },
                  onTap: () {
                    context
                        .read<PlaceOrderViewModel>()
                        .setFreelancer(freelancer.id);
                    setState(() {}); // لتحديث حالة الـ selection
                  },
                ),
              );
            },
          );
        } else if (state is FreelancersViewModelStatesError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }
}
