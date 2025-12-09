import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/views/widgets/offer_card.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/views/widgets/offer_header.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/get_offers_view_model/get_offers_view_model.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/get_offers_view_model/get_offers_view_model_states.dart';
import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../../core/components/dismissible_error_card.dart';
import '../../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../freelancer/presentation/cubit/update_order_status_view_model/update_order_status_view_model.dart';
import '../../../../../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../../../../client_home_view.dart';
import '../../view_model/update_offer_status_view_model/update_offer_status_states.dart';
import '../../view_model/update_offer_status_view_model/update_offer_status_view_model.dart';

class OffersBottomSheetContent extends StatelessWidget {
  final String orderId;
  final OrderEntity order;

  const OffersBottomSheetContent({
    super.key,
    required this.orderId,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final offersViewModel = context.read<GetOffersViewModel>();

    return BlocConsumer<UpdateOfferStatusViewModel, UpdateOfferStatusStates>(
      listener: (context, state) {
        if (state is UpdateOfferStatusLoadingState) {
          showTemporaryMessage(context, local.loading, MessageType.success);
        } else if (state is UpdateOfferStatusErrorState) {
          showTemporaryMessage(context, local.error_temp, MessageType.error);
        } else if (state is UpdateOfferStatusSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const ClientHomeView(initialIndex: 1),
            ),
            (route) => false,
          );
          showTemporaryMessage(
            context,
            order.status == OrderStatus.Accepted
                ? local.offer_accepted_successfully
                : local.offer_rejected_successfully,
            MessageType.success,
          );
          offersViewModel.getOffers(orderId); // refresh offers
        }
      },
      builder: (context, updateState) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,

          child: BlocBuilder<GetOffersViewModel, GetOffersViewModelStates>(
            builder: (context, state) {
              if (state is GetOffersViewModelLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetOffersViewModelError) {
                return Center(child: Text("Error: ${state.message}"));
              } else if (state is GetOffersViewModelSuccess) {
                final offers = state.offers;
                return Column(
                  children: [
                    OffersHeader(
                      title: local.offersReceived,
                      count: offers.length,
                      filters: [
                        OfferSortBy.price,
                        OfferSortBy.delivery,
                        OfferSortBy.rating,
                      ],

                    ),
                    Expanded(
                      child: offers.isNotEmpty
                          ? ListView.builder(
                              itemCount: offers.length,
                              itemBuilder: (context, index) {
                                final offer = offers[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical:  8.0),
                                  child: OfferCard(
                                    order: order,
                                    offer: offer,
                                    onAcceptOffer: () {
                                      context
                                          .read<UpdateOfferStatusViewModel>()
                                          .acceptOfferAndRejectOthers(
                                            offer.offer.orderId,
                                            offer.offer.id,
                                          );
                                    },
                                  ),
                                );
                              },
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Assets.assetsImagesempty,
                                  height: 200.h,
                                  width: 200.w,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  local.no_offers_yet,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: Colors.grey,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                    ),
                  ],
                );
              }
              return Center(
                child: Text(
                  local.no_offers_yet,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
