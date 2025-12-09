import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
 abstract class ChangePasswordRepo {
   Future<Either<Failures, void>> changePassword(String currentPassword, String newPassword  );
 }