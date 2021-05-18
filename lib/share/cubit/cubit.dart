import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories-model.dart';
import 'package:shop_app/models/favourite-model.dart';
import 'package:shop_app/models/favourite-page-model.dart';
import 'package:shop_app/models/home-model.dart';
import 'package:shop_app/models/login-model.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favourites/favourites-screen.dart';
import 'package:shop_app/modules/home/home-screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/settings/settings-screen.dart';
import 'package:shop_app/share/component/component.dart';
import 'package:shop_app/share/component/constant.dart';
import 'package:shop_app/share/cubit/states.dart';
import 'package:shop_app/share/network/local/cash-helper.dart';
import 'package:shop_app/share/network/remote/dio-helper.dart';
import 'package:shop_app/share/network/remote/end-points.dart';

class ShopCubit extends Cubit<States> {
  ShopCubit() : super(InitState());
  static ShopCubit getInstance(context) => BlocProvider.of(context);

  //Toggle between pages
  int pageIndex = 0;
  List<String> title = ['Home', 'Categories', 'Favourites', 'Settings'];
  List<Widget> pages = [
    Home(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];
  changPage(int index) {
    pageIndex = index;
    emit(ChangePageState());
  }
  //Home & Categories

  HomeModel homeModel;
  Map<int, bool>favourites={};
  getProducts() {
    print(token);
    DioHelper.getData(endPoint: HomeUrl,token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favourites.addAll({element.id:element.inFavourite});
      });
      print(favourites);
      emit(HomeGetDataState());
    }).catchError((onError) {
      print('Error getDataMethod: ' + onError.toString());
    });
  }

  CategoriesModel categoriesModel;
  getCategories() {
    DioHelper.getData(endPoint: CategoriesUrl).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(HomeGetCategoriesState());
    }).catchError((onError) {
      print('Error getDataMethod: ' + onError.toString());
    });
  }

  //Favourite button
  FavouriteModel favouriteModel;
  changeFavourite(int id) {
    favourites[id]=!favourites[id];
    emit(HomeChangeFavouriteState());
    DioHelper.postData(
      url: FavouriteUrl,
      data: {
        'product_id': id,
      },
      token: token,
    ).then((value) {
      favouriteModel=FavouriteModel.fromJson(value.data);
      if(favouriteModel.status==false)
        favourites[id]=!favourites[id];
      else
        getFavourite();
    }).catchError((onError) {
      print(onError);
      favourites[id]=!favourites[id];
      emit(HomeChangeFavouriteErrorState());
    });
  }
  //Favourite
  FavouritePageModel favouritePageModel;
  getFavourite() {
    emit(FavouriteLoadingState());
    DioHelper.getData(
        endPoint: FavouriteUrl,
      token: token,
    ).then((value) {
       favouritePageModel= FavouritePageModel.fromJson(value.data);
      emit(HomeGetFavouriteState());
    }).catchError((onError) {
      print('Error getDataMethod: ' + onError.toString());
    });
  }
  //LogOut
  logOut(context){
    print(token);
    DioHelper.postData(url: LogoutUrl, data:{
    },
      token: token,
    ).then((value){
      print(value);
      CashHelper.removeData('token').then((value) {
        print('$value /////  $token  //// ${CashHelper.getData('token')} ');
        navigateAndFinish(context, Login());
      });
    }).catchError((onError){
      print(onError);
    });
  }
  //Profile
  LoginModel profile;
  getProfile(){
    DioHelper.getData(endPoint: ProfileUrl,token: token).then((value){
      profile=LoginModel.fromJson(value.data);
      emit(SettingsGetUserDataSuccessState(profile));
    }).catchError((onError){
      print(onError);
    });
  }
}
