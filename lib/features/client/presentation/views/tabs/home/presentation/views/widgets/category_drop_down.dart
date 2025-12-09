import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/view_model/place_order_view_model/place_order_view_model.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/widgets/custom_drop_down.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';

class CategoryDropDown extends StatefulWidget {
  const CategoryDropDown({super.key,required this.selectedCategory});
final   String? selectedCategory;

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final Map<String, String> categories = {
      "academic_sources": local.academicSources,
      "scientific_reports": local.scientificReports,
      "mind_maps": local.mindMaps,
      "translation": local.translation,
      "summaries": local.summaries,
      "scientific_projects": local.scientificProjects,
      "presentations": local.presentations,
      "statistical_analysis": local.statistical_analysis,
      "proofreading": local.proofreading,
      "resume": local.resume,
      "programming": local.programming,
      "tutorials": local.tutorials,
      "consultations": local.consultations,
      "graphic_design": local.graphic_design,
      "engineering_services": local.engineering_services,
      "financial_services": local.financial_services,
      "other": local.other,
    };
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: CustomDropdown(
        value: context.read<PlaceOrderViewModel>().selectedCategory,
        items: categories,

        hint: widget.selectedCategory ?? "Select Category",
        onChanged: (value) {
          setState(() {
            context.read<PlaceOrderViewModel>().selectedCategory = value ?? widget.selectedCategory;
          });
        },
      ),
    );
  }
}
