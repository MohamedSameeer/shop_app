import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favourites/favourites-screen.dart';
import 'package:shop_app/modules/home/home-screen.dart';
import 'package:shop_app/modules/settings/settings-screen.dart';
import 'package:shop_app/share/cubit/states.dart';

class ShopCubit extends Cubit<States>{
  ShopCubit():super(InitState());
  static ShopCubit getInstance(context)=>BlocProvider.of(context);

  //Toggle between pages
  int pageIndex=0;
  List<String>title=['Home','Categories','Favourites','Settings'];
  List <Widget> pages=[
    Home(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];
  changPage(int index){
    pageIndex=index;
    emit(ChangePageState());
  }


}