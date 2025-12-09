

import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';

import '../../../../domain/repos/my_jobs/delete_order_repo/delete_order_repo.dart';
import '../../../data_sources/remote/delete_order_data_source/delete_order_data_source.dart';
@Injectable(as:  DeleteOrderRepo)
class DeleteOrderRepoImpl implements  DeleteOrderRepo {
  final DeleteOrderRemoteDataSource deleteOrderRemoteDataSource;
  DeleteOrderRepoImpl(this.deleteOrderRemoteDataSource);
  @override
  Future<Either<Failures, void>> deleteOrder(String orderId) {
 return deleteOrderRemoteDataSource.deleteOrder(orderId);
  }

}