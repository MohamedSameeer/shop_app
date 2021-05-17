import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories-model.dart';
import 'package:shop_app/models/home-model.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favourites/favourites-screen.dart';
import 'package:shop_app/modules/home/home-screen.dart';
import 'package:shop_app/modules/settings/settings-screen.dart';
import 'package:shop_app/share/cubit/states.dart';
import 'package:shop_app/share/network/remote/dio-helper.dart';
import 'package:shop_app/share/network/remote/end-points.dart';

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
  //Home & Categories

  HomeModel homeModel;
  getProducts(){
    DioHelper.getData(endPoint: HomeUrl).then((value){
      homeModel=HomeModel.fromJson(value.data);
      emit(HomeGetDataState());
    }).catchError((onError){
      print('Error getDataMethod: '+onError.toString());
    });
  }

  CategoriesModel categoriesModel;
  getCategories(){
    DioHelper.getData(endPoint: CategoriesUrl).then((value){
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(HomeGetCategoriesState());
    }).catchError((onError){
      print('Error getDataMethod: '+onError.toString());
    });
  }

}