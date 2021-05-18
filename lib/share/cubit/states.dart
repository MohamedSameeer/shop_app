import 'package:shop_app/models/favourite-model.dart';
import 'package:shop_app/models/login-model.dart';

abstract class States{}

class InitState extends States{}

class ChangePageState extends States{}

class HomeGetDataState extends States{}

class HomeGetCategoriesState extends States{}

class HomeGetFavouriteState extends States{}

class HomeChangeFavouriteSuccessState extends States{
  FavouriteModel model;
  HomeChangeFavouriteSuccessState(this.model);
}
class HomeChangeFavouriteState extends States{}

class  HomeChangeFavouriteErrorState extends States{}

class  FavouriteLoadingState extends States{}

class SettingsGetUserDataSuccessState extends States{
  LoginModel profile;

  SettingsGetUserDataSuccessState(this.profile);
}