import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login-model.dart';
import 'package:shop_app/modules/home/home-screen.dart';
import 'package:shop_app/modules/login/login-states.dart';
import 'package:shop_app/share/component/component.dart';
import 'package:shop_app/share/network/remote/end-points.dart';
import 'package:shop_app/share/network/remote/dio-helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  
  LoginCubit():super(LoginInitState());
  static LoginCubit getInstance(BuildContext context)=>BlocProvider.of(context);
  
  //Password Handling
  IconData suffix=Icons.remove_red_eye;
  bool isHidden=true;
  changePasswordState(){
    isHidden= !isHidden;
    suffix=isHidden?Icons.remove_red_eye:Icons.remove_red_eye_outlined;
    emit(LoginChangePasswordState());
  }
  //Post Api
  LoginModel loginModel;
  login(String email, String password,BuildContext context){
    DioHelper.postData(lang:'ar', url: LoginUrl, data: {
      'email':email,
      'password':password,
    }).then((value){
      loginModel=LoginModel.fromJson(value.data);
      navigateTo(context, Home());
      emit(LoginSuccessState(loginModel));
    }).catchError((onError){
      print(onError);
    });
  }
}