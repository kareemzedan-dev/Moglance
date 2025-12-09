
import '../../../domain/entities/register_response_entity/register_response_entity.dart';

class RegisterResponseDm extends RegisterResponseEntity {
  RegisterResponseDm({super.user, super.message, super.token});

  RegisterResponseDm.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserDm.fromJson(json['user']) : null;
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'message': message,
      'token': token,
    };
  }
}

class UserDm extends RegisterUserEntity {
  UserDm({super.firstName, super.lastName, super.email, super.password, super.role});

  UserDm.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
