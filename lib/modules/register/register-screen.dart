import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/register-cubit.dart';
import 'package:shop_app/modules/register/register-states.dart';
import 'package:shop_app/share/component/component.dart';
import 'package:shop_app/share/network/local/cash-helper.dart';

class Register extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                if (state.registerModel.status) {
                  CashHelper.saveData('token', state.registerModel.data.token)
                      .then((value) {
                    if (value)
                      toast(
                          msg: state.registerModel.message,
                          state: ToastState.SUCCESS);
                  });
                } else {
                  toast(
                      msg: state.registerModel.message,
                      state: ToastState.ERROR);
                }
              }
            },
            builder: (context, state) => Scaffold(
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
                                'Register',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "Register now to browse hot offers",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              defaultTextFormField(
                                controller: nameController,
                                label: 'Name',
                                prefix: Icon(Icons.person),
                                textType: TextInputType.text,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              defaultTextFormField(
                                controller: phoneController,
                                label: 'Phone number',
                                prefix: Icon(Icons.phone),
                                textType: TextInputType.phone,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              defaultTextFormField(
                                controller: emailController,
                                label: 'Email Address',
                                prefix: Icon(Icons.email_outlined),
                                textType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              defaultTextFormField(
                                controller: passController,
                                label: 'Password',
                                isPassword:
                                    RegisterCubit.getInstance(context).isHidden,
                                prefix: Icon(Icons.lock_outline),
                                textType: TextInputType.visiblePassword,
                                suffix: IconButton(
                                  icon: Icon(
                                      RegisterCubit.getInstance(context).suffix),
                                  onPressed: () {
                                    RegisterCubit.getInstance(context)
                                        .changePasswordState();
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              defaultButton(
                                  text: 'Register',
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      RegisterCubit.getInstance(context).register(
                                          nameController.text,
                                          phoneController.text,
                                          emailController.text,
                                          passController.text,
                                          context);
                                    }
                                  }),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            )
        )
    );
  }
}
