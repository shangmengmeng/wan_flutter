import 'package:flutter/material.dart';

class GlobalConfig{
  static bool dark = false;

  static getThemeData(bool dark){
    if(dark){
      return themeDataDark;
    }else{
      return themeDataLight;
    }
  }

 static Theme theme = getThemeData(dark);

  static ThemeData themeDataLight = new ThemeData(
    //主题色
    primarySwatch: Colors.blue,
    //状态栏颜色
    primaryColor: Colors.blue,

    primaryColorBrightness: Brightness.light,

  );

  static ThemeData themeDataDark = new ThemeData.dark();



}

