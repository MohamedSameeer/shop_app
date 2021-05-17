import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home-model.dart';
import 'package:shop_app/modules/home/home-states.dart';
import 'package:shop_app/share/network/remote/end-points.dart';
import 'package:shop_app/share/network/remote/dio-helper.dart';

class HomeCubit extends Cubit<HomeStates>{

  HomeCubit():super(HomeInitState());
  static HomeCubit getInstance(context)=>BlocProvider.of(context);

  HomeModel homeModel;
  getProducts(){
    DioHelper.getData(endPoint: HomeUrl).then((value){
      homeModel=HomeModel.fromJson(value.data);
      emit(HomeGetDataState());
    }).catchError((onError){
      print('Error getDataMethod: '+onError.toString());
    });
  }
}