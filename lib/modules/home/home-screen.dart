import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home-model.dart';
import 'package:shop_app/modules/home/home-cubit.dart';
import 'package:shop_app/modules/home/home-states.dart';
import 'package:shop_app/share/network/local/cash-helper.dart';
import 'package:shop_app/share/style/colors.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (BuildContext context) => HomeCubit()..getProducts(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return HomeCubit.getInstance(context).homeModel != null
              ? builderWidget(HomeCubit.getInstance(context).homeModel)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget builderWidget(HomeModel model) {
    return SingleChildScrollView(
      child: Column(
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
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 1/1.58,
              children: List.generate(model.data.products.length,
                  (index) => buildGridProduct(model.data.products[index])),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(HomeProductsModel product) => Container(
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
                  IconButton(icon: Icon(Icons.favorite_border), onPressed: (){}),
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
}
