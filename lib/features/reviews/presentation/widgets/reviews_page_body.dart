import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/features/reviews/presentation/widgets/rating_break_down.dart';
import 'package:taskly/features/reviews/presentation/widgets/review_item.dart';
import 'package:taskly/features/reviews/presentation/widgets/user_avatar.dart';


import '../../../../config/l10n/app_localizations.dart';
import '../../../../core/di/di.dart';
import '../../domain/entities/reviews_entity/reviews_entity.dart';
import '../manager/get_user_reviews_view_model/get_user_reviews_states.dart';
import '../manager/get_user_reviews_view_model/get_user_reviews_view_model.dart';

class ReviewsPageBody extends StatelessWidget {
  const ReviewsPageBody({
    super.key,
    required this.userId,
    required this.userRole,
    required this.userName,
    required this.userImage,
    required this.userRating,
  });

  final String userId, userRole, userName, userImage ;
  final double userRating ;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => getIt<GetUserReviewsViewModel>()..getUserReviews(userId, userRole),
      child: BlocBuilder<GetUserReviewsViewModel, GetUserReviewsStates>(
        builder: (context, state) {
          final viewModel = context.read<GetUserReviewsViewModel>();
          final allReviews = state is GetUserReviewsSuccess ? state.reviewsList : <ReviewsEntity>[];

          final receivedReviews = allReviews.where((r) => r.role != userRole).toList();
          final total = viewModel.getTotal(receivedReviews);
          final avg = viewModel.calculateAverage(receivedReviews);
          final ratings = viewModel.calculateRatings(receivedReviews);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // User info
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      UserAvatar(radius: 40.r,
                          userName: userName,
                          imagePath: userImage),
                      SizedBox(height: 8.h),
                      Text(
                        userName,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                      ),
                    ],
                  ),
                ),

                // Rating card
                Card(
                  elevation: 10,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1.w),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                               userRating.toString(),
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24.sp,
                                    ),
                              ),
                              Text(
                                "($total ${local.reviewsReceived})",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: RatingBreakdown(ratings: ratings, total: total),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // Reviews list
                Expanded(
                  child: state is GetUserReviewsLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state is GetUserReviewsError
                          ? Center(
                              child: Text(
                                state.error,
                                style: const TextStyle(color: Colors.red),
                              ),
                            )
                          : receivedReviews.isEmpty
                              ? Center(
                                  child: Text(
                                    local.noReviewsReceived,
                                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: receivedReviews.length,
                                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                                  itemBuilder: (context, index) {
                                    final review = receivedReviews[index];
                                    return ReviewItem(
                                      role: userRole,
                                      review: review,
                                      onDelete: () {},
                                      userId: userRole == "client" ? review.freelancerId : review.clientId,
                                    );
                                  },
                                ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

enum ReviewsTabType { given, received }

class _ReviewsTab extends StatelessWidget {
  final String userId;
  final String userRole;
  final ReviewsTabType tabType;

  const _ReviewsTab({
    required this.userId,
    required this.userRole,
    required this.tabType,
  });

  @override
  Widget build(BuildContext context) {
        final local = AppLocalizations.of(context)!;
    return BlocBuilder<GetUserReviewsViewModel, GetUserReviewsStates>(
      builder: (context, state) {
        if (state is GetUserReviewsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetUserReviewsError) {
          return Center(
            child: Text(state.error, style: const TextStyle(color: Colors.red)),
          );
        }
        if (state is GetUserReviewsSuccess) {

          final filteredReviews = state.reviewsList.where((review) {
            if (tabType == ReviewsTabType.given) {
              return review.role == userRole;
            } else {
              return review.role != userRole;
            }
          }).toList();

          if (filteredReviews.isEmpty) {
            return Center(
              child: Text(
                tabType == ReviewsTabType.given
                    ? local.noReviewsGiven
                    : local.noReviewsReceived,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: filteredReviews.length,
            separatorBuilder: (_, __) => SizedBox(height: 8.h),
            itemBuilder: (context, index) {
              final review = filteredReviews[index];
              return ReviewItem(
                role: userRole,
                review: review,
                onDelete: () {},
                userId: userId,
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
