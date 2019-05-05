import 'package:flutter/material.dart';
import 'package:wan_flutter/api/net/NetService.dart';
import 'package:wan_flutter/model/SubChildModel.dart';
import 'package:wan_flutter/model/SubModel.dart';
import 'package:wan_flutter/ui/webview/MyWebViewPage.dart';

class SubPage extends StatefulWidget {
  final parentContext;

  const SubPage({Key key, this.parentContext}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SubPageState();
}

class SubPageState extends State<SubPage> with TickerProviderStateMixin {
  List<SubData> _subList = new List();

  @override
  void initState() {
    super.initState();
    _getSubList();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController =
        new TabController(length: _subList.length, vsync: this);
    return MaterialApp(
      theme: ThemeData.light(),
      home: _subList.length == 0
          ? Text("")
          : Scaffold(
              appBar: AppBar(
                title: TabBar(
                    isScrollable: true,
                    controller: tabController,
                    tabs: _subList.map((SubData item) {
                      return Container(
                          padding: EdgeInsets.only(bottom: 15, top: 15),
                          child: Text(
                            item.name,
                            style: TextStyle(fontSize: 16),
                          ));
                    }).toList()),
              ),
              body: TabBarView(
                  controller: tabController,
                  children: _subList.map((SubData item) {
                    return ChildSubPage(id:item.id,parentContext:widget.parentContext);
                  }).toList()),
            ),
    );
  }

  Future<void> _getSubList() async {
    NetService().getSubList((SubModel bean) {
      setState(() {
        _subList = bean.data;
      });
    });
  }
}

class ChildSubPage extends StatefulWidget {
  final id;
  final parentContext;

  const ChildSubPage({Key key, this.id, this.parentContext}) : super(key: key);


  @override
  State<StatefulWidget> createState() => ChildSubPageState();
}

class ChildSubPageState extends State<ChildSubPage> {
  List<SubChildDatas> _childList = new List();

  //分页加载的页数
  int _page = 0;
  bool _hasMore = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getChildList();
    _scrollController.addListener(() {
      if (_hasMore) {
        //滑动到底
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _page++;
          _loadMoreChildList(_page);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _getChildList,
      child:_childList.length==0?Text(""): ListView.builder(
        itemCount: _childList.length+1,
          controller: _scrollController,
          itemBuilder: _selectWidget),
    );
  }


  Widget _selectWidget(BuildContext context, int position) {
    if (position == _childList.length ) {
      if (_hasMore) {
        return _loadMoreWidget();
      } else {
        return _endWidget();
      }
    } else {
      return _itemView(context, position);
    }

  }

  Widget _itemView(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(widget.parentContext, new MaterialPageRoute(builder: (context){
          return MyWebViewPage(title: _childList[index].title,url: _childList[index].link,);
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
                    _childList[index].author,
                    style: TextStyle(color: Color(0xff666666),fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    child: Text(
                      _childList[index].niceDate,
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
                _childList[index].title,
                style: TextStyle(color: Color(0xff555555), fontSize: 16,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                _childList[index].superChapterName,
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



  Future<void> _getChildList() async {
    NetService().getChildSubList(0, widget.id, (SubChildModel bean) {
      setState(() {
        if (bean.data.datas.length < 20) {
          _hasMore = false;
        }
        _childList = bean.data.datas;
      });
    });
  }

  Future<void> _loadMoreChildList (int page) async {
    NetService().getChildSubList(page, widget.id, (SubChildModel bean) {
      setState(() {
        if (bean.data.datas.length < 20) {
          _hasMore = false;
        }
        _childList.addAll(bean.data.datas);
      });
    });
  }
}
