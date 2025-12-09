import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/core/components/custom_search_text_field.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/widgets/freelancer_info_list_view.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../profile/presentation/manager/profile_view_model/profile_view_model.dart';
import '../../view_model/fetch_all_freelancers_view_model/fetch_all_freelancers_view_model.dart';

class PrivateHireSection extends StatefulWidget {
  PrivateHireSection({super.key, required this.selectedId});
  String? selectedId;
  String? selectedQuery;

  @override
  State<PrivateHireSection> createState() => _PrivateHireSectionState();
}
class _PrivateHireSectionState extends State<PrivateHireSection> {
  String? selectedQuery; // حركته هنا

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<FetchAllFreelancersViewModel>()..getAllFreelancer();
    final local = AppLocalizations.of(context)!;

    return Container(
      height: 260.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => viewModel,
              ),
              BlocProvider(
                create: (context) => getIt<ProfileViewModel>() ,
              ),
            ],

            child: Column(
              children: [
                CustomSearchTextField(
                  hintTexts: [
                    local.search_freelancers_hint,
                    local.choose_best_match_hint
                  ],
                  onChanged: (query) {
                    setState(() {
                      selectedQuery = query;
                    });
                  },
                ),
                FreelancerInfoListView(
                  selectedId: widget.selectedId,
                  searchQuery: selectedQuery,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
