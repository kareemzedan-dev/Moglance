import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/features/reviews/domain/entities/reviews_entity/reviews_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/domain/entities/order_entity/order_entity.dart';
import '../manager/get_user_reviews_view_model/get_user_reviews_view_model.dart';
import '../manager/submit_rating_view_model/submit_rating_states.dart';
import '../manager/submit_rating_view_model/submit_rating_view_model.dart';

class RatingBottomSheet extends StatefulWidget {
  final OrderEntity order;
  final String currentUserId;
  final String receiverId;
  final String userName;

  const RatingBottomSheet({
    super.key,
    required this.order,
    required this.currentUserId,
    required this.receiverId,
    required this.userName,
  });

  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  double _rating = 5.0;
  String _comment = '';
  bool _isSubmitting = false;

  bool get _isClient => widget.currentUserId == widget.order.clientId;
  bool get _isFreelancer => widget.currentUserId == widget.order.freelancerId;
  String get _ratedUserId => _isClient
      ? widget.order.freelancerId!
      : widget.order.clientId;
  String get _ratedUserRole => _isClient ? 'freelancer' : 'client';
  String get _currentUserRole => _isClient ? 'client' : 'freelancer';
  String get _ratedUserName =>
      _isClient ? AppLocalizations.of(context)!.freelancer : AppLocalizations.of(context)!.client;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => getIt<SubmitRatingViewModel>(),
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20.w,
          right: 20.w,
          top: 20.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: BlocConsumer<SubmitRatingViewModel, SubmitRatingStates>(
          listener: (context, state) {
            if (state is SubmitRatingStatesSuccess) {

              setState(() => _isSubmitting = false);
              Navigator.of(context).pushNamedAndRemoveUntil(
                _currentUserRole == "client"
                    ? RoutesManager.clientHome
                    : RoutesManager.freelancerHome,
                    (route) => false,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(loc.rating_success),
                  backgroundColor: Colors.green,
                ),

              );
              context.read<GetUserReviewsViewModel>().getUserReviews(widget.currentUserId, _currentUserRole);
            } else if (state is SubmitRatingStatesError) {
              setState(() => _isSubmitting = false);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.failure.message ?? loc.rating_fail),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is SubmitRatingStatesLoading) {
              return SizedBox(
                height: 200.h,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  loc.rate_experience,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  loc.experience_with(widget.userName ??""),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 24.h),
                Center(
                  child: RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 30.sp,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: Text(
                    _getRatingText(_rating, loc),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  loc.add_comment,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    onChanged: (value) => _comment = value,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: loc.share_experience,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.w),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isSubmitting
                            ? null
                            : () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          loc.skip,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isSubmitting
                            ? null
                            : () {
                          _submitRating(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: _isSubmitting
                            ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : Text(
                          loc.submit_rating,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            );
          },
        ),
      ),
    );
  }

  String _getRatingText(double rating, AppLocalizations loc) {
    if (rating >= 4.5) return loc.excellent;
    if (rating >= 4.0) return loc.very_good;
    if (rating >= 3.0) return loc.good;
    if (rating >= 2.0) return loc.fair;
    return loc.poor;
  }

  void _submitRating(BuildContext context) {
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    final review = ReviewsEntity(
      id: const Uuid().v4(),
      freelancerId: _isFreelancer ? widget.currentUserId : _ratedUserId,
      clientId: _isClient ? widget.currentUserId : _ratedUserId,
      orderId: widget.order.id,
      comment: _comment.isNotEmpty ? _comment : "",
      rating: _rating.toString(),
      createdAt: DateTime.now(),
      role: _currentUserRole,
    );

    context.read<SubmitRatingViewModel>().submitRating(
      reviews: review,
    );
  }
}
