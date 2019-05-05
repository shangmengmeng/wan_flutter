import 'package:flutter/material.dart';
import 'package:wan_flutter/api/net/NetService.dart';
import 'package:wan_flutter/model/ProjectDetailModel.dart';
import 'package:wan_flutter/model/ProjectModel.dart';
import 'package:wan_flutter/ui/webview/MyWebViewPage.dart';
import 'package:wan_flutter/widget/ProgressState.dart';

class ProjectPage extends StatefulWidget {
  final parentContext;

  const ProjectPage({Key key, this.parentContext}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProjectPageState();
}

class ProjectPageState extends State<ProjectPage> with TickerProviderStateMixin{
  List<ProjectData> titleDataList = new List();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _getProjectTitle();
  }

  @override
  Widget build(BuildContext context) {
    _tabController = new TabController(length: titleDataList.length, vsync:this );

    return MaterialApp(
        theme: ThemeData.light(),
        home: new Scaffold(
          appBar: new AppBar(
            title: new TabBar(
              controller: _tabController,
              tabs: titleDataList.map((ProjectData item) {
                return Container(
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    child:Text(item.name)
                );
              }).toList(),
              isScrollable: true,
            ),
          ),
          body: new TabBarView(
            controller: _tabController,
              children: titleDataList.map((ProjectData item) {
                return ProjectChildPage(
                    id: item.id, parentContext: widget.parentContext);
              }).toList()),
        ),



    );
  }

  _getProjectTitle() {
    new NetService().getProjectTitleList((ProjectModel data) {
      setState(() {
        titleDataList = data.data;
      });
    });
  }
}
//------------------------------------------------------------------------------
class ProjectChildPage extends StatefulWidget {
  final id;
  final parentContext;

  const ProjectChildPage({Key key, this.id, this.parentContext})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ProjectChildPageState();
}

class ProjectChildPageState extends State<ProjectChildPage> {
  List<ProjectDatas> detaillist = new List();
  //分页加载的页数
  int _page = 0;
  bool _hasMore = true;
  ScrollController _scrollController = ScrollController();
@override
  void initState() {
    super.initState();
    _getProjectTitle();
    _scrollController.addListener((){
      if (_hasMore) {
        //滑动到底
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _page++;
          _loadMoreProjectList(_page);
        }
      }
    });
  }
//  new MyProgress(count:4,milliseconds:700,size: new Size(100.0, 20.0))
//  ):
  @override
  Widget build(BuildContext context) {
    return detaillist.length==0?Container(
        alignment: Alignment.center,
        child: Text("")): RefreshIndicator(
      onRefresh: _getProjectTitle,
      child: ListView.builder(
        controller: _scrollController ,
        itemCount: detaillist.length==0?1:detaillist.length+1,
        itemBuilder: _selectWidget,
      ),
    );
  }

  Widget _selectWidget(BuildContext context, int position) {
    if (position == detaillist.length ) {
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
          return MyWebViewPage(title: detaillist[index].title,url: detaillist[index].link,);
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
                    detaillist[index].author,
                    style: TextStyle(color: Color(0xff666666),fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    child: Text(
                      detaillist[index].niceDate,
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
                detaillist[index].title,
                style: TextStyle(color: Color(0xff555555), fontSize: 16,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                detaillist[index].superChapterName,
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



  Future<void> _getProjectTitle() async {
    new NetService().getProjectDetailList((ProjectDetailModel data){
     setState(() {
       if (data.data.datas.length < 15) {
         _hasMore = false;
       }
       detaillist = data.data.datas;
     });
    }, 0, widget.id);
  }

  Future<void> _loadMoreProjectList(int page) async{

    new NetService().getProjectDetailList((ProjectDetailModel data){
      if (data.data.datas.length < 15) {
        _hasMore = false;
      }
      setState(() {
        detaillist.addAll(data.data.datas);
      });
    }, page, widget.id);

  }




}
