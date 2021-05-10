import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//class ThemeChanger with ChangeNotifier{
//  ThemeData _themeData;
//
//  ThemeChanger(this._themeData);
//  getTheme() => _themeData;
//
//  setTheme(ThemeData theme){
//    _themeData = theme;
//
//    notifyListeners();
//  }
//}

final darktheme= ThemeData(
  brightness: Brightness.dark,
      textTheme: TextTheme(
      body1: TextStyle(fontSize: 20,color: Colors.teal[100])
)
);

final lighttheme = ThemeData(
  brightness: Brightness.light,
      textTheme: TextTheme(
body1: TextStyle(fontSize: 20,color: Colors.black54)
)
);

class ThemeNotifier extends ChangeNotifier{
  final String key = 'theme';
  SharedPreferences _preferences;
  bool _darktheme;

  bool get darkTheme => _darktheme;

  ThemeNotifier(){
    _darktheme=true;
    _loadFromPrefs();
  }
  toogleTheme()async{
    _darktheme=!_darktheme;
    await _saveToPrefs();
   await notifyListeners();
  }
  _initPrefs()async{
    if(_preferences==null)
      _preferences=await SharedPreferences.getInstance();
  }

  _loadFromPrefs()async{
    await _initPrefs();
    _darktheme=_preferences.getBool(key)??true;
    notifyListeners();
  }
  _saveToPrefs()async{
    await _initPrefs();
    _preferences.setBool(key,_darktheme);
  }
}