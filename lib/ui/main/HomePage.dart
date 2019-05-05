import 'package:flutter/material.dart';
import 'package:wan_flutter/api/net/NetService.dart';
import 'package:wan_flutter/model/ArticleModel.dart';
import 'package:wan_flutter/model/BannerModel.dart';
import 'package:wan_flutter/ui/main/MyDrawer.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_flutter/ui/webview/MyWebViewPage.dart';

class HomePage extends StatefulWidget {
  final mContext;
  const HomePage({Key key, this.mContext}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomPageState();
}

class HomPageState extends State<HomePage> {
  var parentContext;

  List<BannerData> _bannerList = new List();
  List<ArticleDatas> _articleList = new List();

  //分页加载的页数
  int _page = 0;
  bool _hasMore = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //初始加载网络数据
    _getBannerData();
    _getListData(0);
    _scrollController.addListener(() {
      if (_hasMore) {
        //滑动到底
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _page++;
          _getListData(_page);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    parentContext = widget.mContext;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("首页"),
            elevation: 0.2,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ],
          ),
          drawer: MyDrawer(),
          body: RefreshIndicator(
            onRefresh: _getListRefreshData,
            child: ListView.builder(
              itemBuilder: _mainWidget,
              itemCount: _articleList.length == 0 ? 1 : _articleList.length + 2,
              controller: _scrollController,
            ),
          )),
    )
    ;
  }

  Widget _mainWidget(BuildContext context, int position) {
    if (position == 0) {
      return Container(
        height: 200,
        child: _bannerList.length == 0 ? Text("") : _swiper(),
      );
    } else if (position == _articleList.length + 1) {
      if (_hasMore) {
        return _loadMoreWidget();
      } else {
        return _endWidget();
      }
    } else {
      return _itemWidget(context, position);
    }
  }

  Swiper _swiper() {
    return Swiper(
      autoplay: true,
      autoplayDelay: 10000,
      scrollDirection: Axis.horizontal,
      pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
              size: 5, //点点没选中时候的大小
              activeSize: 8, //点点选中后的大小
              color: Colors.white, //点点的颜色
              activeColor: Colors.deepOrangeAccent),
          alignment: Alignment.bottomRight),
      itemCount: _bannerList.length,
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          _bannerList[index].imagePath,
          fit: BoxFit.fill,
        );
      },
      onTap: (index) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyWebViewPage(
                    title: _bannerList[index].title,
                    url: _bannerList[index].url)));
      },
    );
  }

  Widget _itemWidget(BuildContext context, int position) {
    return InkWell(
        onTap: () {
          Navigator.push(
              parentContext,
              MaterialPageRoute(
                  builder: (context) => MyWebViewPage(
                      title: _articleList[position - 1].title,
                      url: _articleList[position - 1].link)));
        },
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              children: <Widget>[
                Container(
                    child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _articleList[position - 1].author.isEmpty
                            ? ""
                            : _articleList[position - 1].author,
                        style:
                            TextStyle(color: Color(0xff666666), fontSize: 12),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _articleList[position - 1].niceDate.isEmpty
                            ? ""
                            : _articleList[position - 1].niceDate,
                        style:
                            TextStyle(color: Color(0xff666666), fontSize: 12),
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                )),
                Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _articleList[position - 1].title.isEmpty
                          ? ""
                          : _articleList[position - 1].title,
                      style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.left,
                    )),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _articleList[position - 1].superChapterName.isEmpty
                              ? ""
                              : _articleList[position - 1].superChapterName,
                          style:
                              TextStyle(color: Color(0xff666666), fontSize: 12),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 0.5,
                  alignment: Alignment.bottomCenter,
                  child: Divider(
                    color: Color(0xff00b7ee),
                  ),
                )
              ],
            )));
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
      height: 50,
      child: Text(
        "---  我是有底线的  ---",
        style: TextStyle(color: Color(0xff666666), fontSize: 12),
      ),
    );
  }

  //加载banner网路数据
  Future<void> _getBannerData() async {
    NetService().getBanner((BannerModel bean) {
      if (bean != null && bean.data.length > 0) {
        setState(() {
          _bannerList = bean.data;
        });
      }
    });
  }

  //我是加载更多
  _getListData(int page) async {
    NetService().getArticleList((ArticleModel bean) {
      if (bean.data.datas.length < 20) {
        _hasMore = false;
      }
      setState(() {
        _articleList.addAll(bean.data.datas);
      });
    }, page);
  }
  //我是刷新数据
  Future<void> _getListRefreshData() async {
    NetService().getArticleList((ArticleModel bean) {
      setState(() {
        _articleList = bean.data.datas;
      });
    }, 0);
  }
}
