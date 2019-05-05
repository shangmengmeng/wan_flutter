import 'package:flutter/material.dart';
import 'package:wan_flutter/GlobalConfig.dart';
import 'package:wan_flutter/ui/webview/MyWebViewPage.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              "flutter男神",
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("images/avatar.jpg"),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                GlobalConfig.dark
                    ? "images/bg_dark.png"
                    : 'images/bg_light.jpg',
              ),
              fit: BoxFit.cover,
            )),
            accountEmail: null,
          ),
          ListTile(
            leading: Icon(
              Icons.collections,
              color: Colors.blue,
            ),
            title: Text(
              "常用网站",
              textAlign: TextAlign.left,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.web,
              color: Colors.blue,
            ),
            title: Text(
              "常用网站",
              textAlign: TextAlign.left,
            ),
            onTap: () {},
          ),
          Container(
            height: 50,
            child: ListTile(
              leading: Icon(
                Icons.wb_sunny,
                color: Colors.blue,
              ),
              title: Text(
                "日间模式",
                textAlign: TextAlign.left,
              ),
              onTap: () {},
            ),
          ),
          Container(
            width: 50,
            child: ListTile(
              leading: Icon(
                Icons.bug_report,
                color: Colors.blue,
              ),
              title: Text(
                "关于",
                style: TextStyle(),
              ),
              onTap: () {
                jumpToAbout();
              },
            ),
          )
        ],
      ),
    );
  }

  void jumpToAbout() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return new MyWebViewPage(
          title: "关于", url: "https://me.csdn.net/qq_22230935");
    }));
  }
}
