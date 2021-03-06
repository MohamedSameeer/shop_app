import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop-layout.dart';
import 'package:shop_app/modules/home/home-screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_board/on_board_screen.dart';
import 'package:shop_app/share/network/local/cash-helper.dart';
import 'package:shop_app/share/network/remote/dio-helper.dart';
import 'package:shop_app/share/themes.dart';

import 'share/component/constant.dart';
import 'share/component/state-observer.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();

  Widget startWidget;
  if(CashHelper.getData('onBoard')!=null){
    if(CashHelper.getData('token')!=null){
      token=CashHelper.getData('token');
      startWidget=ShopLayout();
    }else
      startWidget=Login();
  }else
    startWidget=OnBoardScreen();
  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      home:startWidget,
    );
  }
}



