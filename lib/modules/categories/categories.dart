import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories-model.dart';
import 'package:shop_app/share/cubit/cubit.dart';
import 'package:shop_app/share/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, States>(
        listener: (context,state){},
        builder: (context,state){
          return ShopCubit.getInstance(context).categoriesModel !=null?Container(
            width: double.infinity,
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder:(context,index)=>buildCategoriesItem( ShopCubit.getInstance(context).categoriesModel, index),
                separatorBuilder:(context,index)=>SizedBox(height: 1,),
                itemCount: ShopCubit.getInstance(context).categoriesModel.data.data.length),
          ):
              Center(child: CircularProgressIndicator());
        }
    );
  }
}

Widget buildCategoriesItem(CategoriesModel categoriesModel, int index) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
            image:NetworkImage(
              categoriesModel.data.data[index].image,
            ),
          width: 100,
          height: 100,
        ),
        SizedBox(width:20.0),
        Text(
          categoriesModel.data.data[index].name,
          style: TextStyle(

          ),
        ),
        Spacer(),
        IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){})
      ],
    ),
  );
}
