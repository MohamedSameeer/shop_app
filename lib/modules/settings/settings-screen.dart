import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/share/component/component.dart';
import 'package:shop_app/share/cubit/cubit.dart';
import 'package:shop_app/share/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, States>(listener: (context, state) {
      if (state is SettingsGetUserDataSuccessState) {
        nameController.text = state.profile.data.name;
        emailController.text = state.profile.data.email;
        phoneController.text = state.profile.data.phone;
      }
    }, builder: (context, state) {
      nameController.text = ShopCubit.getInstance(context).profile.data.name;
      emailController.text = ShopCubit.getInstance(context).profile.data.email;
      phoneController.text = ShopCubit.getInstance(context).profile.data.phone;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            defaultTextFormField(
                controller: nameController,
                label: 'Name',
                prefix: Icon(Icons.person),
                textType: TextInputType.text),
            SizedBox(height: 20.0),
            defaultTextFormField(
                controller: emailController,
                label: 'E-mail',
                prefix: Icon(Icons.mail_outline),
                textType: TextInputType.emailAddress),
            SizedBox(height: 20.0),
            defaultTextFormField(
                controller: phoneController,
                label: 'Phone',
                prefix: Icon(Icons.phone),
                textType: TextInputType.phone),
            SizedBox(height: 20.0),
            defaultButton(
                onPressed: () {
                  ShopCubit.getInstance(context).logOut(context);
                },
                text: 'Logout'),
          ],
        ),
      );
    });
  }
}
