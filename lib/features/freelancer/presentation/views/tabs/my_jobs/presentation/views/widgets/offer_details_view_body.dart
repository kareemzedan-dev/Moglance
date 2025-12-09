import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/core/helper/date_time_formatter.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/freelancer/presentation/cubit/fetch_order_details_view_model/fetch_order_details_view_model.dart';
import 'package:taskly/features/freelancer/presentation/cubit/fetch_order_details_view_model/fetch_order_details_view_model_states.dart';
import '../../../../../../../../shared/presentation/views/widgets/attachments_section.dart';
import '../../../../../../../../shared/presentation/views/widgets/description_section.dart';
import '../../../../../../../../shared/presentation/views/widgets/job_header_section.dart';
import '../../../../find_work/presentation/views/widgets/about_job_section.dart';
import '../../../../find_work/presentation/views/widgets/client_details_section.dart';

class OfferDetailsViewBody extends StatelessWidget {
  const OfferDetailsViewBody({super.key,required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context) {
  return  BlocProvider (
      create: (context) =>  getIt<FetchOrderDetailsViewModel>()..fetchOrderDetails(orderId),
        child:  BlocBuilder<FetchOrderDetailsViewModel, FetchOrderDetailsViewModelStates>(
        builder: (context, state) {
          if(state is FetchOrderDetailsViewModelStatesLoading)
            {
              return   const Center(child: CircularProgressIndicator(color: ColorsManager.primary,));
            }
          if(state is FetchOrderDetailsViewModelStatesError){
            return Center(child: Text(state.message),);
          }
          if (state is FetchOrderDetailsViewModelStatesSuccess){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:   [
                          JobHeader(title: state.orderEntity.title ,category:  state.orderEntity.category!,date:  state.orderEntity.createdAt.toTimeAgo(context),),
                          const Divider(thickness: 1, color: Colors.grey),
                          DescriptionSection(description: state.orderEntity.description ,),
                          const Divider(thickness: 1, color: Colors.grey),
                          ClientDetailsSection(userId:  state.orderEntity.clientId,),

                          const Divider(thickness: 1, color: Colors.grey),
                          AttachmentsSection(attachmentEntity:  state.orderEntity.attachments,isFreelancer: true,),
                          const Divider(thickness: 1, color: Colors.grey),

                          AboutJobSection( order: state.orderEntity),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          );}
          return const SizedBox();
        },
      )
    );
  }
}
