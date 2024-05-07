import 'package:atelieoliveira/src/data/database/shared_preferences_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesImpl extends IsharedPreferencs{

  @override
  getString(String key) async {
    return await SharedPreferences.getInstance().then((value){
      return value.getString(key);
    });
  }

  @override
  void saveString(String key, String data) async{
    await SharedPreferences.getInstance().then((value){
      value.setString(key, data);
    });
  }
  
  @override
  deleteString(String key) async {
    await SharedPreferences.getInstance().then((value){
      value.remove(key);
    });
  }

}