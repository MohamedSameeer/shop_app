import 'package:flutter/material.dart';
import 'package:shop_app/share/network/local/cash-helper.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          MaterialButton(onPressed:(){
            CashHelper.removeData("token");
          })
        ],
      ),
    );
  }
}
