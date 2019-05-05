import 'package:flutter/material.dart';
import 'package:wan_flutter/api/net/NetService.dart';
import 'package:wan_flutter/model/TreeModel.dart';
import 'package:wan_flutter/ui/tree_detail/TreeDetail.dart';

class TreePage extends StatefulWidget {
  final parentContext;

  const TreePage({Key key, this.parentContext}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TreePageState();
}

class TreePageState extends State<TreePage> {
  List<TreeData> _treeParentList = new List();

  List<TreeChildren> _treeList = new List();

  List<TreeChildren> get treeList => _treeList;

  set treeList(List<TreeChildren> value) {
    _treeList = value;
  }

  @override
  void initState() {
    super.initState();

    _getTreeList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "知识体系",
            style: TextStyle(color: Color(0xfffffffff)),
          ),
        ),
        body: ListView.builder(
            itemCount: _treeParentList.length,
            itemBuilder: _itemWidget),
      ),
    );
  }

  Widget _itemWidget(BuildContext context, int index) {
    _treeList = _treeParentList[index].children;
    return InkWell(
     onTap: (){
       Navigator.push(widget.parentContext, MaterialPageRoute(builder: (context){
         return TreeDetail(name:_treeParentList[index].name,treeList: _treeList,);
       }));
     },

      child:  Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 0,bottom: 6,left: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(_treeParentList[index].name,style: TextStyle(color: Color(0xff555555),fontSize: 16,fontWeight: FontWeight.w700),),),
                GridView.count(
                  //水平子Widget之间间距
                  crossAxisSpacing: 2.0,
                  //垂直子Widget之间间距
                  mainAxisSpacing: 3.0,
                  //GridView内边距
                  padding: EdgeInsets.all(5.0),
                  //一行的Widget数量
                  crossAxisCount: 3,
                  //子Widget宽高比例
                  childAspectRatio: 2.0,
                  physics: new NeverScrollableScrollPhysics(), //增加
                  shrinkWrap: true, //增加
                  children: _treeList.map((item){
                    return _gridItemWidget(item);
                  }).toList(),
                ),
                Container(
                  height: 0.5,
                  child: Divider(
                    color: Color(0xfff00b7ee),
                  ),
                )
              ],
            ),
          )),
    );



  }


  Widget _gridItemWidget(TreeChildren itemData){
    
    return InkWell(

      child: Text(itemData.name),
    );
    
  }
  

  Future<void> _getTreeList() async {
    new NetService().getTreeList((TreeModel data) {
      setState(() {
        _treeParentList = data.data;
      });
    });
  }
}
