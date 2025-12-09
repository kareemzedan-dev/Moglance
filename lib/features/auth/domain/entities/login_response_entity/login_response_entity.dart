class LoginResponseEntity {
  String? token;
  LoginUserEntity? user;
  String? message;
  LoginResponseEntity({this.token, this.user, this.message});
}

class LoginUserEntity {
  String? email;
  String? password;
  String? role;
  LoginUserEntity({this.email, this.password,this.role});
}
