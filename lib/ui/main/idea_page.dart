import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class IdeaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>  _IdeaPageState();
}

class _IdeaPageState extends State<IdeaPage> {
  Widget myView() {
    return  Container(
      child:  ListView(
        children: <Widget>[
           Container(
              padding: const EdgeInsets.only(top: 20.0),
              height: 70.0,
              color: Colors.grey[200],
              child:  Container(
                child:  ListTile(
                  leading:  Icon(Icons.camera),
                  title:  Text("朋友圈"),
                ),
                color: Colors.white,
              )),
           Container(
            color: Colors.grey[200],
            height: 70.0,
            padding: const EdgeInsets.only(top: 20.0),
            child:  Container(
              color: Colors.white,
              child:  ListTile(
                leading:  Icon(Icons.crop_free),
                title:  Text("扫一扫"),
              ),
            ),
          ),
           Container(
            color: Colors.grey[200],
            height: 70.0,
            padding: const EdgeInsets.only(top: 20.0),
            child:  Container(
              color: Colors.white,
              child:  ListTile(
                leading:  Icon(Icons.star),
                title:  Text("看一看"),
              ),
            ),
          ),
           Container(
            color: Colors.grey[200],
            height: 70.0,
            padding: const EdgeInsets.only(top: 20.0),
            child:  Container(
              color: Colors.white,
              child:  ListTile(
                leading:  Icon(Icons.search),
                title:  Text("搜一搜"),
              ),
            ),
          ),
           Container(
            color: Colors.grey[200],
            height: 70,
            padding: const EdgeInsets.only(top: 20),
            child:  Container(
              color: Colors.white,
              child:  ListTile(
                leading:  Icon(Icons.people),
                title:  Text("附近的人"),
              ),
            ),
          ),
           Container(
              color: Colors.grey[200],
              height: 70,
              padding: const EdgeInsets.only(top: 20),
              child:  Container(
                color: Colors.white,
                child:  ListTile(
                  leading:  Icon(Icons.hourglass_empty),
                  title:  Text("漂流瓶"),
                ),
              )),
           Container(
            color: Colors.grey[200],
            height: 70,
            padding: const EdgeInsets.only(top: 20),
            child:  FlatButton(
                color: Colors.white,
                onPressed: () {
                  Fluttertoast.showToast(
                    msg: "我被点击了",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                  );
                },
                child:  ListTile(
                  leading:  Icon(Icons.shopping_cart),
                  title:  Text("购物车"),
                )),
          ),
           Container(
            color: Colors.grey[200],
            height: 70,
            padding: const EdgeInsets.only(top: 20),
            child:  Container(
              color: Colors.white,
                child:  ListTile(
                  onTap: (){
                    Fluttertoast.showToast(
                      msg: "我被点击了",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                    );
                  },
                  leading:  Icon(Icons.games),
                  title:  Text("游戏"),

                )),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:  Scaffold(
        appBar:  AppBar(
          title:  Text("想法"),
          actions: <Widget>[ Container()],
        ),
        body:  Center(
          child: myView(),
        ),
      ),

    );
  }
}
