import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../view_model/get_offers_view_model/get_offers_view_model.dart';
class OffersFilters extends StatefulWidget {
  final List<OfferSortBy> filters;

  const OffersFilters({super.key, required this.filters});

  @override
  State<OffersFilters> createState() => _OffersFiltersState();
}

class _OffersFiltersState extends State<OffersFilters> {
  OfferSortBy? selectedFilter;

  @override
  Widget build(BuildContext context) {
    final offersViewModel = context.read<GetOffersViewModel>();
    final local = AppLocalizations.of(context)!;

    String filterLabel(OfferSortBy sortBy) {
      switch (sortBy) {
        case OfferSortBy.price:
          return local.price;
        case OfferSortBy.delivery:
          return local.delivery;
        case OfferSortBy.rating:
          return local.rating;
      }
    }

    return Row(
      children: [
        Text(
          local.filterBy,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 10.w),

        ...widget.filters.map(
              (filter) => Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: FilterChip(
              label: Text(
                filterLabel(filter),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: selectedFilter == filter,
              backgroundColor: ColorsManager.primary.withOpacity(.5),
              selectedColor: ColorsManager.primary.withOpacity(0.7),
              labelStyle: const TextStyle(color: Colors.white),
              onSelected: (_) {
                setState(() {
                  selectedFilter = filter;
                });

                offersViewModel.sortOffers(filter);
              },
            ),
          ),
        ),
      ],
    );
  }
}
