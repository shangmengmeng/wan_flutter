import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  final parentContext;

  const MinePage({Key key, this.parentContext}) : super(key: key);
  @override
  State<StatefulWidget> createState() =>MinePageState();

}

class MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      child: Column(
        children: <Widget>[
          Container(
            height: 240,
            width: 640,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/mine_bac.png"),
                   fit: BoxFit.fill
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Card(
                elevation: 10,
                margin: EdgeInsets.only(top: 50,left: 50,right: 50),
                child: Container(
                  height: 100,
                  width: 200,
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:NetworkImage("https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1556625871&di=4fcf7ad1d49703f17777d15aac1263dc&src=http://b-ssl.duitang.com/uploads/item/20182/21/2018221142159_MZ33z.jpeg"),
                        radius: 30,
                          ),
                      Expanded(child: Text("FancyMeng",textAlign: TextAlign.center,style: TextStyle(color: Color(0xff00b7ee),fontSize: 18),))
                    ],
                  ),
                ),
              ),
            ),

          ),
          Container(

            child: Column(
              children: <Widget>[
               Container(
                 padding: EdgeInsets.only(top: 20),
                 child:  Text("清风徐来，我依然在 ……"),
               ),
                Container(
                  padding: EdgeInsets.only(top: 20,left: 30,right: 30),
                  child:  Text("做自己喜欢的事情，看看风听听雨，或向往山的耸屹，流连江水的粼漓 ...",style: TextStyle(color: Color(0xff666666),letterSpacing: 8,),),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  height: 150,
                  width: 300,
                  child: Image.network("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1556637693784&di=777062a46beb82f6d9ddd2b2484c11ff&imgtype=0&src=http%3A%2F%2Fzhuanti.spacechina.com%2Fn1238648%2Fn1238732%2Fc1241423%2Fpart%2F1241438.jpg",fit: BoxFit.cover,),
                )


              ],
            ),
          )

        ],
      ),
    );

  }
}