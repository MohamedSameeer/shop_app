class HomeModel {
  bool status;
  String message;
  _HomeDataModel data;
  HomeModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=_HomeDataModel.fromJson(json['data']);
  }
}

class _HomeDataModel {
  List banners=[];
  List products=[];
  _HomeDataModel.fromJson(Map<String,dynamic> json){
    json['banners'].forEach((element){
      banners.add(_HomeBannerModel.fromJson(element));
    });
    json['products'].forEach((element){
      products.add(HomeProductsModel.fromJson(element));
    });
  }
}

class _HomeBannerModel {
  int id;
  String image;
  _HomeBannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class HomeProductsModel {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool inFavourite;
  bool inCart;

  HomeProductsModel.fromJson(Map<String, dynamic> json) {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavourite=json['in_favorites'];
    inCart=json['in_cart'];
  }
}
