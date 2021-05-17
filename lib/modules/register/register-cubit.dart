import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop-layout.dart';
import 'package:shop_app/models/login-model.dart';
import 'package:shop_app/modules/home/home-screen.dart';
import 'package:shop_app/modules/register/register-states.dart';
import 'package:shop_app/share/component/component.dart';
import 'package:shop_app/share/network/remote/dio-helper.dart';
import 'package:shop_app/share/network/remote/end-points.dart';

class RegisterCubit extends Cubit <RegisterStates>{
  RegisterCubit() : super(RegisterInitState());
  static RegisterCubit getInstance(context) => BlocProvider.of(context);

  //Password Handling
  IconData suffix=Icons.remove_red_eye;
  bool isHidden=true;
  changePasswordState(){
    isHidden= !isHidden;
    suffix=isHidden?Icons.remove_red_eye:Icons.remove_red_eye_outlined;
    emit(RegisterChangePasswordState());
  }

  //Post Api
  LoginModel registerModel;
  register(name, phone, email, password,context) {
    DioHelper.postData(url: RegisterUrl, data: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    }).then((value){
      print(value.data);
      registerModel=LoginModel.fromJson(value.data);
      navigateAndFinish(context, ShopLayout());
      emit(RegisterSuccessState(registerModel));
    }).catchError((onError) {
      print(onError);
    });
  }
}
