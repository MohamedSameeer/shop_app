import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories-model.dart';
import 'package:shop_app/models/home-model.dart';
import 'package:shop_app/share/component/component.dart';
import 'package:shop_app/share/cubit/cubit.dart';
import 'package:shop_app/share/cubit/states.dart';
import 'package:shop_app/share/network/local/cash-helper.dart';
import 'package:shop_app/share/style/colors.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, States>(
      listener: (BuildContext context, state) {
        if(state is HomeChangeFavouriteSuccessState){
          if(state.model.status==false){
            toast(msg: state.model.message, state: ToastState.ERROR);
          }
        }
      },
      builder: (BuildContext context, state) {
        return ShopCubit.getInstance(context).homeModel != null &&
            ShopCubit.getInstance(context).categoriesModel!=null
            ? builderWidget(ShopCubit.getInstance(context).homeModel,context)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget builderWidget(HomeModel model,context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(e.image),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1.0,
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index)=>buildCategoriesItem( ShopCubit.getInstance(context).categoriesModel, index),
                      separatorBuilder:(context,index)=>SizedBox(width: 10,),
                      itemCount: ShopCubit.getInstance(context).categoriesModel.data.data.length),
                ),
                SizedBox(height: 10,),
                Text(
                    'Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  color: Colors.grey[300],
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    childAspectRatio: 1/1.7,
                    children: List.generate(model.data.products.length,
                        (index) => buildGridProduct(model.data.products[index],context)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(HomeProductsModel product,context) => Container(
    padding: EdgeInsets.all(10.0),
    color: Colors.white,
    child: Stack(
      alignment: AlignmentDirectional.bottomStart,
      children:[
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(product.image),
                width: double.infinity,
                height: 200,
              ),
              Text(
                product.name,
                style: TextStyle(
                  height: 1.3,
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

  Widget buildCategoriesItem(CategoriesModel model,int index)=>Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image(
          image:NetworkImage(
            model.data.data[index].image,
          ),
        width: 100,
        height: 100,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(.6),
        child: Text(
          model.data.data[index].name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      )
    ],
  );
}
