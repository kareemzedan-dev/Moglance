import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/payments/data/data_sources/remote/create_payment_remote_data_source.dart';
import 'package:taskly/features/payments/data/data_sources/remote/get_payment_remote_data_source.dart';

import 'package:taskly/features/payments/domain/entities/payment_entity.dart';

import '../../../domain/repositories/payment_repos/payment_repo.dart';
@Injectable(as:PaymentRepos )
class CreatePaymentRepoImpl extends PaymentRepos {
  CreatePaymentRemoteDataSource createPaymentRemoteDataSource;
  GetPaymentRemoteDataSource getPaymentRemoteDataSource;
  CreatePaymentRepoImpl(this.createPaymentRemoteDataSource,this.getPaymentRemoteDataSource);
  @override
  Future<Either<Failures, PaymentEntity>> createPayment(PaymentEntity paymentEntity) {
 return createPaymentRemoteDataSource.createPayment(paymentEntity);
  }
  
  @override
  Future<Either<Failures, PaymentEntity>> getPayment(String orderId) {
    return getPaymentRemoteDataSource.getPayment(orderId);
     
  }

}