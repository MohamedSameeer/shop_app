import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/login-cubit.dart';
import 'package:shop_app/modules/register/register-screen.dart';
import 'package:shop_app/share/component/component.dart';
import 'package:shop_app/share/network/local/cash-helper.dart';

import 'login-states.dart';

class Login extends StatelessWidget {
  var emailController=TextEditingController();
  var passController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create:(context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener:(context, state){
          if(state is LoginSuccessState){
            if(state.loginModel.status){
              CashHelper.saveData('token', state.loginModel.data.token).then((value){
                if(value)
                  toast(msg:state.loginModel.message, state: ToastState.SUCCESS);
              });

            }else{
              toast(msg:state.loginModel.message, state: ToastState.ERROR);
            }
          }else if(state is LoginLoadingState)
            Center(child: CircularProgressIndicator());
        } ,
        builder:(context, state)=>Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline3.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height:20.0 ,),
                      Text(
                        "login now to browse hot offers",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color:Colors.grey
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      defaultTextFormField(
                        controller: emailController,
                        label: 'Email Address',
                        prefix: Icon(Icons.email_outlined),
                        textType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20.0,),
                      defaultTextFormField(
                        controller: passController,
                        label: 'Password',
                        isPassword: LoginCubit.getInstance(context).isHidden,
                        prefix: Icon(Icons.lock_outline),
                        textType: TextInputType.visiblePassword,
                        suffix:IconButton(
                          icon: Icon(LoginCubit.getInstance(context).suffix),
                          onPressed:(){
                            LoginCubit.getInstance(context).changePasswordState();
                          },
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      defaultButton(text: 'Login',onPressed: (){
                          if(formKey.currentState.validate()) {
                            LoginCubit.getInstance(context).login(emailController.text, passController.text, context);
                          }
                      }),
                      SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account"),
                          TextButton(onPressed: (){
                            navigateTo(context, Register());
                          }, child: Text("REGISTER")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
