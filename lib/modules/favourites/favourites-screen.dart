import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favourite-page-model.dart';
import 'package:shop_app/share/component/component.dart';
import 'package:shop_app/share/cubit/cubit.dart';
import 'package:shop_app/share/cubit/states.dart';
import 'package:shop_app/share/style/colors.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, States>(
        listener: (context,state){
        },
        builder: (context,state){
          if(state is FavouriteLoadingState)
            return Center(child: CircularProgressIndicator());
          return Container(
            width: double.infinity,
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder:(context,index)=>favouriteBuilder(ShopCubit.getInstance(context).favouritePageModel.favouriteData.data[index].product, context),
                separatorBuilder:(context,index)=>defaultSeparator(),
                itemCount: ShopCubit.getInstance(context).favouritePageModel.favouriteData.data.length),
          );
        }
    );
  }
  Widget favouriteBuilder(Product product,context)=> Container(
    padding: EdgeInsets.all(20),
    width: double.infinity,
    height: 200,
    child: Stack(
      alignment: AlignmentDirectional.bottomStart,
      children:[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(product.image),
              width: 120,
              height: 200,
              fit: BoxFit.fill,
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        product.price.toString(),
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(width: 10,),
                      if(product.discount!=0)
                        Text(
                          product.oldPrice.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                          icon: CircleAvatar(
                            backgroundColor:ShopCubit.getInstance(context).favourites[product.id]?defaultColor:Colors.grey,
                            child: Icon(
                                Icons.favorite_border
                            ),
                          ),
                          onPressed: (){
                            ShopCubit.getInstance(context).changeFavourite(product.id);
                          }
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        if(product.discount!=0)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0,),
            child: Text(
              'DISCOUNT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
            color: Colors.red,
          ),
      ],
    ),
  );
}
