
import 'package:flutter/material.dart';
class MyBottomNavigationBar extends StatefulWidget{
  final int index;
  final ValueChanged<int> changedIndex;

  const MyBottomNavigationBar({Key key, this.index, this.changedIndex}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new MyBottomNavigationBarState();

}

class MyBottomNavigationBarState extends State<MyBottomNavigationBar> with AutomaticKeepAliveClientMixin {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTapChanged,
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.blue,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('首页'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.streetview),
          title: Text('分类'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.class_),
          title: Text('更多'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          title: Text('大神'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('我的'),
        ),
      ],

    );
  }

  void onTapChanged(int value) {
    setState(() {
      currentIndex = value;
    });

    widget.changedIndex(value);

  }

  @override
  bool get wantKeepAlive => true;
}