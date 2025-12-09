import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/views/widgets/empty_state_animation.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import 'package:taskly/features/freelancer/presentation/cubit/get_freelancer_offers_view_model/get_freelancer_offers_states.dart';
import 'package:taskly/features/freelancer/presentation/cubit/get_freelancer_offers_view_model/get_freelancer_offers_view_model.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/my_jobs/presentation/views/widgets/tracking_offers_list_view.dart';
import '../../../../../../../../../config/l10n/app_localizations.dart';

class MyJobsTabViewBody extends StatefulWidget {
  const MyJobsTabViewBody({super.key});

  @override
  State<MyJobsTabViewBody> createState() => _MyJobsTabViewBodyState();
}

class _MyJobsTabViewBodyState extends State<MyJobsTabViewBody> {
  late final GetFreelancerOffersViewModel viewModel;
  StreamSubscription<(OfferEntity, String)>? _subscription;

  final freelancerId = SharedPrefHelper.getString(StringsManager.idKey)!;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<GetFreelancerOffersViewModel>();
    viewModel.getFreelancerOffers(freelancerId, null);

    _subscription = viewModel.subscribeToOffers(freelancerId).listen((event) {
      viewModel.getFreelancerOffers(freelancerId, null);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return TabBarView(
      children: [
        _buildOfferTab(
          context: context,
          status: "pending",
          emptyAnimation: 'assets/lotties/Loading.json',
          emptyMessage: local.no_pending_offers,
        ),
        _buildOfferTab(
          context: context,
          status: "accepted",
          emptyAnimation: 'assets/lotties/Progress.json',
          emptyMessage: local.no_accepted_offers,
        ),
        _buildOfferTab(
          context: context,
          status: "completed",
          emptyAnimation: 'assets/lotties/Success.json',
          emptyMessage: local.no_completed_projects_yet,
        ),
        _buildOfferTab(
          context: context,
          status: "rejected",
          emptyAnimation: 'assets/lotties/cancelled.json',
          emptyMessage: local.no_rejected_offers,
        ),
      ],
    );
  }

  Widget _buildOfferTab({
    required BuildContext context,
    required String status,
    required String emptyAnimation,
    required String emptyMessage,
  }) {
    final local = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<GetFreelancerOffersViewModel, GetFreelancerOffersStates>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is GetFreelancerOffersLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetFreelancerOffersErrorState) {
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lotties/no_internet.json', width: 200, height: 200),
                const SizedBox(height: 20),
                Text(state.message),
              ],
            ));
          }

          if (state is GetFreelancerOffersSuccessState) {
            final offers = state.offers
                .where((o) => o.offerStatus.toLowerCase() == status)
                .toList();

            if (offers.isEmpty) {
              return EmptyStateAnimation(
                animationPath: emptyAnimation,
                message: emptyMessage,
              );
            }

            return TrackingOffersListView(
              offer: offers,
              isPending: status == "pending",
              isAccepted: status == "accepted",
              isCompleted: status == "completed",
              isRejected: status == "rejected",
            );
          }

          return Center(child: Text(local.no_offers_yet));
        },
      ),
    );
  }
}
