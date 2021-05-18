import 'package:shop_app/models/login-model.dart';

abstract class LoginStates{}

class LoginInitState extends LoginStates{}
class LoginChangePasswordState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginLoadingState extends LoginStates {}
class LoginErrorState extends LoginStates{}