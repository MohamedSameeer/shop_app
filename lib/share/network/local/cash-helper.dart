import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{
  static SharedPreferences pref;

  static init()async{
    pref=await SharedPreferences.getInstance();
  }

  static dynamic getData (String key){
    return pref.get(key);
  }

  static Future<bool> saveData (String key, dynamic value)async{
   if(value is bool)return await pref.setBool(key, value);
   else if(value is String)return await pref.setString(key, value);
   else if(value is int)return await pref.setInt(key, value);
   return await pref.setDouble(key, value);
  }

  static Future<bool>removeData(String key)async{
    return await pref.remove(key);
  }
}