import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taskly/core/components/custom_search_text_field.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/widgets/service_category_grid_view.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/widgets/user_info_home_header.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
import '../../view_model/client_home_view_model/client_home_view_model.dart';

class ClientHomeTabViewBody extends StatefulWidget {
  const ClientHomeTabViewBody({super.key});

  @override
  State<ClientHomeTabViewBody> createState() => _ClientHomeTabViewBodyState();
}

class _ClientHomeTabViewBodyState extends State<ClientHomeTabViewBody> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<ClientHomeViewModel>(context, listen: false);
      viewModel.loadServices(context);
    });
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ClientHomeViewModel>();
    final local = AppLocalizations.of(context)!;

    return SingleChildScrollView(

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
              UserInfoHomeHeader(),
            SizedBox(height: 30.h),
            CustomSearchTextField(
              hintTexts:   [local.search_for_services],
              controller: _searchController,
              onChanged: viewModel.onSearchChanged,
            ),
            SizedBox(height: 30.h),
            if (!viewModel.isLoaded)
              const Center(child: CircularProgressIndicator())
            else if (viewModel.filteredServices.isEmpty)
              Column(
                children: [
                  Lottie.asset("assets/lotties/empty.json", height: 200.h),
                  Text(
                    local.noServicesFound,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("الخدمات",style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,

                  ),),
                  SizedBox(height: 16.h,),
                  ServiceCategoryGridView(services: viewModel.filteredServices),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
