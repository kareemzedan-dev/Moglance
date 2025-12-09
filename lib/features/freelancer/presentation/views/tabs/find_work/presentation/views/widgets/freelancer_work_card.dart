import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../../core/utils/category_translator.dart';
import '../../../../../../../data/models/favorite_order_model/favorite_order_model.dart';
import '../../../../../../../domain/entities/favorite_order_entity/favorite_order_entity.dart';
import '../../view_model/add_favorite_order_view_model/add_favorite_order_states.dart';
import '../../view_model/add_favorite_order_view_model/add_favorite_order_view_model.dart';
import '../../view_model/remove_favorite_order_view_model/remove_favorite_order_view_model.dart';
import '../../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../../../core/helper/date_time_formatter.dart';
import '../../../../../../../../../core/helper/relative_time.dart';
import '../../../../../../../../../features/shared/domain/entities/order_entity/order_entity.dart';
import 'action_row.dart';
import 'delivery_info.dart';

class FreelancerWorkCard extends StatelessWidget {
  const FreelancerWorkCard({super.key, required this.order,required  this.offeredOrderIds ,  required this.addFavViewModel,});
  final OrderEntity order;
  final List<String> offeredOrderIds;
  final AddFavoriteOrderViewModel addFavViewModel; // ✅ أضف هنا

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Card(
      elevation: 10,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 2.w),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderRow(date: order.createdAt.toTimeAgo(context), orderId: order.id, addFavViewModel: addFavViewModel,),
              const SizedBox(height: 10),
              Title(order.title),
              const SizedBox(height: 5),

          CategoryChip(CategoryTranslator.getArabicName(context, order.category ?? "")),
              const SizedBox(height: 16),
              Description(order.description ??local.noDescription),
              const SizedBox(height: 16),
              DeliveryInfo(deliveryTime: order.deadline!.toRelative(context)),
              const SizedBox(height: 16),
              ActionsRow(
                order: order,
                actions: [
                  ActionItem(
                    title: local.viewDetails,
                    icon: Icons.remove_red_eye_outlined,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesManager.jobDetailsView,
                        arguments: order,
                      );
                    },
                  ),
                  ActionItem(
                    title: offeredOrderIds.contains(order.id)

                        ? "مرسل بالفعل"

                        : local.send_offers,
                    icon: offeredOrderIds.contains(order.id)
                        ? Icons.check_circle
                        : Icons.send,
                    isOffer: true,
                    onTap: offeredOrderIds.contains(order.id)
                        ? null
                        : () {
                      Navigator.pushNamed(
                        context,
                        RoutesManager.sendOfferView,
                        arguments: order,
                      );
                    },
                  ),


                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key, required this.date, required this.orderId, required this.addFavViewModel});
  final String date;
  final String orderId;
  final AddFavoriteOrderViewModel addFavViewModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddFavoriteOrderViewModel, AddFavoriteOrderStates>(
      listener: (context, state) {
        if (state is AddFavoriteOrderSuccessState && state.orderId == orderId) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is AddFavoriteOrderRemovedState && state.orderId == orderId) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Removed from favorites")));
        }
        if (state is AddFavoriteOrderErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: _HeaderContent(date: date, orderId: orderId  , addFavViewModel: addFavViewModel,),
    );
  }
}
class _HeaderContent extends StatelessWidget {
  final String date;
  final String orderId;
  final AddFavoriteOrderViewModel addFavViewModel; // أضف هذا

  const _HeaderContent({
    required this.date,
    required this.orderId,
    required this.addFavViewModel, // أضف هنا
  });

  @override
  Widget build(BuildContext context) {
    final removeFavViewModel = context.read<RemoveFavoriteOrderViewModel>();
final local = AppLocalizations.of(context)!;
    return BlocBuilder<AddFavoriteOrderViewModel, AddFavoriteOrderStates>(
      bloc: addFavViewModel, // ✅ استخدم النسخة الممررة
      builder: (context, state) {
        final isFavorite = addFavViewModel.isFavorite(orderId);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${local.posted} $date",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (isFavorite) {
                  final favEntity = addFavViewModel.getFavoriteEntityByOrderId(orderId);
                  if (favEntity != null) {
                    final result = await removeFavViewModel.removeFavoriteOrder(favEntity.id);
                    result.fold(
                          (failure) => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Error removing favorite'))),
                          (_) {
                        addFavViewModel.removeFavorite(orderId);

                        final updatedJsonList = addFavViewModel.favoriteOrderIds
                            .map((id) {
                          final e = addFavViewModel.getFavoriteEntityByOrderId(id)!;
                          return jsonEncode(FavoriteOrderModel(
                            id: e.id,
                            userId: e.userId,
                            orderId: e.orderId,
                            createdAt: e.createdAt,
                          ).toJson());
                        }).toList();

                        SharedPrefHelper.setStringList('favoriteOrders', updatedJsonList);
                      },
                    );
                  }
                } else {
                  final favEntity = FavoriteOrderEntity(
                    id: '',
                    userId: SharedPrefHelper.getString(StringsManager.idKey) ?? "",
                    orderId: orderId,
                    createdAt: DateTime.now(),
                  );

                  await addFavViewModel.toggleFavorite(favEntity);

                  final updatedJsonList = addFavViewModel.favoriteOrderIds
                      .map((id) {
                    final e = addFavViewModel.getFavoriteEntityByOrderId(id)!;
                    return jsonEncode(FavoriteOrderModel(
                      id: e.id,
                      userId: e.userId,
                      orderId: e.orderId,
                      createdAt: e.createdAt,
                    ).toJson());
                  }).toList();

                  SharedPrefHelper.setStringList('favoriteOrders', updatedJsonList);
                }
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                color: isFavorite ? Colors.red : Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// ------------------- باقي الويدجتس -------------------

class Title extends StatelessWidget {
  const Title(this.title, {super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 18.sp,
      ),
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip(this.category, {super.key});
  final String category;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        height: 30.h,
        decoration: BoxDecoration(
          color: ColorsManager.primary.withOpacity(.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Text(
            category,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: Colors.white,

            ),
          ),
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description(this.description, {super.key});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      ),
      maxLines: 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }
}
String getArabicCategoryName(String backendValue, Map<String, String> categories) {
  return categories[backendValue] ?? backendValue;
}
