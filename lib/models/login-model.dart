class LoginModel{
  bool status;
  String message;
  _UserData data;
  LoginModel.fromJson(Map<String, dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?_UserData.fromJson(json['data']):null;
  }
}
class _UserData{
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  _UserData.fromJson(Map<String, dynamic> json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];
  }
}