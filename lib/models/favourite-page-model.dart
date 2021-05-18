class FavouritePageModel{
  bool status;
  String message;
  _FavouritePageDataModel favouriteData;
  FavouritePageModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
   favouriteData=_FavouritePageDataModel.fromJson(json['data']);
  }
}
class _FavouritePageDataModel{
  int currentPage;
  List<_Data> data=[];
  _FavouritePageDataModel.fromJson(Map<String,dynamic>json){
    currentPage=json['currentPage'];
    json['data'].forEach((element) {
      data.add(_Data.fromJson(element));
    });
  }
}
class _Data{
  int id;
  Product product;
  _Data.fromJson(Map<String,dynamic>json){
    id=json['id'];
    product=Product.fromJson(json['product']);
  }

}
class Product{
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  String description;

  Product.fromJson(Map<String, dynamic>json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
  }
}