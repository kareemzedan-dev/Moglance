import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/utils/network_utils.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/attachments/data/models/attachments_dm/attachments_dm.dart';
import 'package:taskly/features/payments/data/data_sources/remote/get_payment_remote_data_source.dart';
import 'package:taskly/features/payments/domain/entities/payment_entity.dart';

@Injectable(as: GetPaymentRemoteDataSource)
class GetPaymentRemoteDataSourceImpl extends GetPaymentRemoteDataSource {
  final SupabaseClient supabase;

  GetPaymentRemoteDataSourceImpl(this.supabase);

  @override
  Future<Either<Failures, PaymentEntity>> getPayment(String orderId) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure(StringsManager.noInternetConnection));
      }
      final response = await supabase
          .from('payments')
          .select()
          .eq('order_id', orderId)
          .limit(1)
          .maybeSingle();

      if (response == null) {
        return const Left(ServerFailure("Payment not found"));
      }

      final attachmentsJson = response['attachments'];

      final attachments = attachmentsJson == null
          ? <AttachmentModel>[]
          : (jsonDecode(attachmentsJson) as List<dynamic>)
              .map((a) => AttachmentModel.fromJson(a as Map<String, dynamic>))
              .toList();

      final payment = PaymentEntity(
        id: response['id'] as String,
        orderId: response['order_id'] as String,
        amount: (response['amount'] as num).toDouble(),
        status: response['status'] as String,
        freelancerId: response['freelancer_id'] as String,
        clientId: response['client_id'] as String,
        updatedAt: DateTime.parse(response['updated_at'] as String),
        createdAt: DateTime.parse(response['created_at'] as String),
        attachments: attachments,
      );

      return Right(payment);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
