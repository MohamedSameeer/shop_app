import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/share/style/colors.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultTextFormField({
  @required controller,
  @required label,
  @required prefix,
  @required textType,
   suffix,
  bool isPassword=false,
})=>TextFormField(
  controller: controller,
  obscureText: isPassword,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: label,
    prefixIcon: prefix,
    suffixIcon: suffix,
  ),
  maxLines: 1,
  keyboardType: textType,
  validator: (String text){
    if(text.isEmpty)
      return "This field can't be empty";
    else
      return null;
  }
);
Widget defaultButton({
  @required onPressed,
  @required text,
})
=>MaterialButton(
  minWidth: double.infinity,
  color: defaultColor,
onPressed: onPressed,
child: Text(text),
);

toast({
  @required msg,
  @required ToastState state,
})=> Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastState{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastState state){
  switch(state){
    case ToastState.SUCCESS:
      return Colors.green;
      break;
    case ToastState.ERROR:
      return Colors.red;
      break;
    case ToastState.WARNING:
      return Colors.amber;
      break;
  }
}