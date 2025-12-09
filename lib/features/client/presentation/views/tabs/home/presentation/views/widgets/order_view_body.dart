import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/client/presentation/views/client_home_view.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/view_model/place_order_view_model/place_order_view_model.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/view_model/place_order_view_model/place_order_view_model_states.dart';
import '../../../../../../../../../core/cache/shared_preferences.dart';
import '../../../../../../../../../core/components/dismissible_error_card.dart';
import 'order_form_section.dart';

class OrderViewBody extends StatefulWidget {
  final String title;
  final String selectedCategory;

  const OrderViewBody({
    super.key,
    required this.title,
    required this.selectedCategory,
  });

  @override
  State<OrderViewBody> createState() => _OrderViewBodyState();
}

class _OrderViewBodyState extends State<OrderViewBody> {
  late PlaceOrderViewModel viewModel;
  List<String> timeUnits = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


    // Initialize only once
    if (timeUnits.isEmpty) {
      viewModel = context.read<PlaceOrderViewModel>();
      final local = AppLocalizations.of(context)!;
      timeUnits = [local.hours, local.days, local.weeks];
      viewModel.initializeOrder(
        title: widget.title,
        category: widget.selectedCategory,
        timeUnits: timeUnits,
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final viewModel = context.read<PlaceOrderViewModel>();

    return BlocConsumer<PlaceOrderViewModel, PlaceOrderViewModelStates>(
      listener: (context, state) {
        if (state is PlaceOrderViewModelStatesSuccess) {
          showTemporaryMessage(context, local.order_created_success, MessageType.success);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const ClientHomeView(initialIndex: 1)),
                (_) => false,
          );
        } else if (state is PlaceOrderViewModelStatesError) {
          showTemporaryMessage(context, state.message ?? local.somethingWentWrong, MessageType.error);
        }
      },
      builder: (context, state) {
        final isLoading = state is PlaceOrderViewModelStatesLoading;

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),

              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: OrderFormSection(
                  selectedHireMethodIndex: viewModel.hireMethodIndex,
                  onHireMethodChanged: (val) => viewModel.setHireMethod(val),
                  onSubmit: () => viewModel.submitOrder(),
                ),
              ),
            ),
            if (isLoading)
              AbsorbPointer(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: ColorsManager.primary,
                      size: 60,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
