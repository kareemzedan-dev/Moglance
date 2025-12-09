import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/services/notification_service.dart';
import 'package:taskly/features/payments/domain/entities/payment_entity.dart';
import '../../../../../core/services/admin_service.dart';
import '../../../../attachments/data/models/attachments_dm/attachments_dm.dart';
import '../../data_sources/remote/create_payment_remote_data_source.dart';

@Injectable(as: CreatePaymentRemoteDataSource)
class CreatePaymentRemoteDataSourceImpl extends CreatePaymentRemoteDataSource {
  final SupabaseClient supabase;

  CreatePaymentRemoteDataSourceImpl(this.supabase);

  @override
  Future<Either<Failures, PaymentEntity>> createPayment(
      PaymentEntity paymentEntity) async {
    try {
      final Map<String, dynamic> data = {
        'id': paymentEntity.id,
        'client_id': paymentEntity.clientId,
        'freelancer_id': paymentEntity.freelancerId,
        'order_id': paymentEntity.orderId,
        'amount': paymentEntity.amount,
        'status': paymentEntity.status,
        'attachments': jsonEncode(
            paymentEntity.attachments.map((e) => e.toJson()).toList()),
        'created_at': paymentEntity.createdAt.toIso8601String(),
        'updated_at': paymentEntity.updatedAt.toIso8601String(),
        'payment_method': paymentEntity.paymentMethod,
        'account_number': paymentEntity.accountNumber,
        'requester_type': paymentEntity.requesterType,
      };

      final response =
          await supabase.from('payments').insert(data).select().single();
      final updateOrderResponse = await supabase
          .from('orders')
          .update({
            "status": "Paid",
          })
          .eq('id', paymentEntity.orderId!)
          .select()
          .maybeSingle();
      //
      // final acceptResponse = await supabase
      //     .from('offers')
      //     .update({"status": "Awaiting Approval"})
      //     .eq('order_id', paymentEntity.orderId)
      //     .select();
      //
      //
      // if (acceptResponse == null) {
      //   return Left(ServerFailure("Failed to accept the offer"));
      // }

      if (updateOrderResponse == null) {
        return const Left(ServerFailure("Failed to update order"));
      }

      final createdPayment = PaymentEntity(
        id: response['id'],
        clientId: response['client_id'],
        freelancerId: response['freelancer_id'],
        orderId: response['order_id'],
        amount: (response['amount'] as num).toDouble(),
        status: response['status'],
        attachments: (jsonDecode(response['attachments']) as List<dynamic>)
            .map((e) => AttachmentModel.fromJson(e))
            .toList(),
        createdAt: DateTime.parse(response['created_at']),
        updatedAt: DateTime.parse(response['updated_at']),
        paymentMethod: response['payment_method'],
        accountNumber: response['account_number'],
        requesterType: response['requester_type'],
      );
      NotificationService().sendNotification(
          receiverId: response['freelancer_id'],
          title: "متابعه حاله الطلب",
          body:
              "لقد تم الدفع بواسطه العميل يرجي الانتظار لحين تأكيد الدفع من قبل الاداره");


      NotificationService().sendNotificationToAllAdmins(
        title: 'إشعار مهم',
        body: 'هذا إشعار لجميع المشرفين',
      );

      return Right(createdPayment);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
