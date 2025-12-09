
import '../../../data/models/register_response_dm/register_response_dm.dart';

class RegisterResponseEntity {
  String? token;
  UserDm? user;
  String? message;

  RegisterResponseEntity({this.token, this.user, this.message});
}

class RegisterUserEntity {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? role;  

  RegisterUserEntity({this.firstName, this.lastName, this.email, this.password, this.role});
}
