import 'package:flutter/material.dart';
import 'package:wan_flutter/api/net/NetService.dart';
import 'package:wan_flutter/model/TreeDetailModel.dart';
import 'package:wan_flutter/model/TreeModel.dart';
import 'package:wan_flutter/ui/webview/MyWebViewPage.dart';

class TreeDetail extends StatefulWidget {
  final treeList;
  final name;

  const TreeDetail({Key key, this.treeList, this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TreeDetailState();
}

class TreeDetailState extends State<TreeDetail> with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<TreeChildren> _treeList = widget.treeList;
    TabController tabController =
        new TabController(length: _treeList.length, vsync: this);
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name,
            style: TextStyle(color: Color(0xffffffff)),
          ),
          bottom: TabBar(
              isScrollable: true,
              controller: tabController,
              tabs: _treeList.map((treeChildren) {
                return Text(treeChildren.name);
              }).toList()),
        ),
        body: TabBarView(
            controller: tabController,
            children: _treeList.map((treeChildren) {
              return ChildTreePage(id:treeChildren.id);
            }).toList()),
      ),
    );
  }
}

class ChildTreePage extends StatefulWidget {
  final id;

  const ChildTreePage({Key key, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() => ChildTreePageState();
}

class ChildTreePageState extends State<ChildTreePage> {

  List<TreeDatas> _detailList = new List();

  //分页加载的页数
  int _page = 0;
  bool _hasMore = true;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _getChildTreeList();


    _scrollController.addListener((){
      if (_hasMore) {
        //滑动到底
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _page++;
          _loadMoreTreeDetailList(_page);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getChildTreeList,
      child: ListView.builder(
          itemCount: _detailList.length+1,
          itemBuilder: selectItem),
    );
  }
  Widget selectItem (BuildContext context ,int position){
    if(position == _detailList.length){
      if (_hasMore) {
        return _loadMoreWidget();
      } else {
        return _endWidget();
      }
    }else {

      return _itemView(context, position);
    }

  }


  Widget _itemView(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context){
          return MyWebViewPage(title: _detailList[index].title,url: _detailList[index].link,);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    _detailList[index].author,
                    style: TextStyle(color: Color(0xff666666),fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    child: Text(
                      _detailList[index].niceDate,
                      style: TextStyle(color: Color(0xff666666),fontSize: 12),
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                _detailList[index].title,
                style: TextStyle(color: Color(0xff555555), fontSize: 16,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                _detailList[index].superChapterName,
                style: TextStyle(color: Color(0xff666666), fontSize: 12),
                textAlign: TextAlign.left,
              ),
              margin: EdgeInsets.only(bottom: 10),
            ),
            Container(
              height: 0.5,
              child: Divider(
                color: Color(0xfff00b7ee),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _loadMoreWidget() {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              backgroundColor: Colors.grey,
              // value: 0.2,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          ),
          Container(
            child: Text("正在加载中...",
                style: TextStyle(color: Color(0xff666666), fontSize: 12)),
          )
        ],
      ),
    );
  }

  Widget _endWidget() {
    return Container(
      alignment: Alignment.center,
      height: 50,
      child: Text(
        "---  我是有底线的  ---",
        style: TextStyle(color: Color(0xff666666), fontSize: 12),
      ),
    );
  }





  Future<void> _getChildTreeList() async{
    NetService().getTreeDetailList(0, widget.id, (TreeDetailModel bean){
      setState(() {
        if(bean.data.datas.length<20){
          _hasMore = false;
        }
        _detailList = bean.data.datas;
      });
    });
  }

  Future<void> _loadMoreTreeDetailList(int page) async {

    NetService().getTreeDetailList(page, widget.id, (TreeDetailModel bean){
      setState(() {
        if(bean.data.datas.length<20){
          _hasMore = false;
        }
        _detailList .addAll(bean.data.datas) ;
      });
    });

  }


}
