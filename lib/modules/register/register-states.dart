import 'package:shop_app/models/login-model.dart';

abstract class RegisterStates{}

class RegisterInitState extends RegisterStates{}

class RegisterChangePasswordState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  LoginModel registerModel;
  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterStates{}