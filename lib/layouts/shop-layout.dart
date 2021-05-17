import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/share/cubit/cubit.dart';
import 'package:shop_app/share/cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopCubit>(
        create: (BuildContext context)=>ShopCubit(),
      child: BlocConsumer<ShopCubit,States>(
        listener: (context,state){},
        builder: (context,state){
          ShopCubit cubit=ShopCubit.getInstance(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.title[cubit.pageIndex],
              ),
            ),
            body: cubit.pages[cubit.pageIndex],
            bottomNavigationBar: BottomNavigationBar(items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favourites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ],
              currentIndex: cubit.pageIndex,
              onTap: (index){
                cubit.changPage(index);
              },
            ),
          );
        },
      ),
    );
  }
}
