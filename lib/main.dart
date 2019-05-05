import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wan_flutter/GlobalConfig.dart';
import 'package:wan_flutter/ui/main/HomePage.dart';
import 'package:wan_flutter/ui/main/MinePage.dart';
import 'package:wan_flutter/ui/main/MyBottomNavigationBar.dart';
import 'package:wan_flutter/ui/main/MyDrawer.dart';
import 'package:wan_flutter/ui/main/ProjectPage.dart';
import 'package:wan_flutter/ui/main/SubPage.dart';
import 'package:wan_flutter/ui/main/TreePage.dart';
import 'package:wan_flutter/ui/main/idea_page.dart';

void main() async {
  bool isDarkTheme = await getTheme();
  runApp(MyApp(isDarkTheme));

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

Future<bool> getTheme() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool isDarkTheme = sp.getBool("isDarkTheme");
  if (isDarkTheme == null) {
    isDarkTheme = false;
  }
  GlobalConfig.dark = isDarkTheme;
  return isDarkTheme;
}

class MyApp extends StatefulWidget {
  final bool isDarkTheme;
  MyApp(this.isDarkTheme);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ThemeData themeData;

  @override
  void initState() {
    super.initState();
    themeData = GlobalConfig.getThemeData(false);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
    ));
    return MaterialApp(
      title: "玩安卓",
      theme: themeData,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>  HomeState();
}

//这里保持不重新构建
class HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0; //当前索引
  List<StatefulWidget> _pageList; //页面
  @override
  void initState() {
    super.initState();
    _pageList = [
      HomePage(mContext: context),
      ProjectPage(parentContext: context),
      TreePage(parentContext: context,),
      SubPage(parentContext: context),
      MinePage(parentContext: context),
    ];

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: null,//只要这里传入空，不影响子类覆盖
        body:  IndexedStack(
          index: _currentIndex,
          children: _pageList,
        ),
        bottomNavigationBar:  MyBottomNavigationBar(
          index: _currentIndex,
          changedIndex: onIndexChanged,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void onIndexChanged(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  Future<bool> _onWillPop() {
    return null;
  }


}
