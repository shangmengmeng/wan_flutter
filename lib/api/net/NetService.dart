import 'package:dio/dio.dart';
import 'package:wan_flutter/model/BannerModel.dart';
import 'package:wan_flutter/model/ProjectDetailModel.dart';
import 'package:wan_flutter/model/ProjectModel.dart';
import 'package:wan_flutter/model/SubChildModel.dart';
import 'package:wan_flutter/model/SubModel.dart';
import 'package:wan_flutter/model/TreeDetailModel.dart';
import 'package:wan_flutter/model/TreeModel.dart';
import '../net/DioManager.dart';
import 'package:wan_flutter/api/Api.dart';
import 'package:wan_flutter/model/ArticleModel.dart';

class NetService {
  void getBanner(Function callback) async {
    DioManager.singleton.dio.get(Api.HOME_BANNER).then((response) {
      callback(BannerModel.fromJsonMap(response.data));
    });
  }

  void getArticleList(Function callback, int page) async {
    DioManager.singleton.dio
        .get(Api.HOME_ARTICLE_LIST + page.toString() + "/json")
        .then((response) {
      callback(ArticleModel.fromJson(response.data));
    });
  }

  void getProjectTitleList(Function callback) async {
    DioManager.singleton.dio.get(Api.PROJECT_TREE).then((response) {
      callback(ProjectModel.fromJsonMap(response.data));
    });
  }

  void getProjectDetailList(Function callback, int page, int id) async {
    DioManager.singleton.dio
        .get(Api.PROJECT_LIST +
            page.toString() +
            "/json?" +
            "cid=" +
            id.toString())
        .then((response) {
      print(response.toString());
      callback(ProjectDetailModel.fromJsonMap(response.data));
    });
  }

  void getTreeList(Function callback) async {
    DioManager.singleton.dio.get(Api.SYSTEM_TREE).then((response) {
      callback(TreeModel.fromJsonMap(response.data));
    });
  }

  //体系下的列表
  void getTreeDetailList(int page, int id, Function callback) {
    DioManager.singleton.dio
        .get(Api.SYSTEM_TREE_CONTENT +
            page.toString() +
            "/json?" +
            "cid=" +
            id.toString())
        .then((response) {
      callback(TreeDetailModel.fromJsonMap(response.data));
    });
  }

  //获取公众号的详情
  void getSubList(Function callback) {
    DioManager.singleton.dio.get(Api.WX_LIST).then((response) {
      callback(SubModel.fromJsonMap(response.data));
    });
  }

//微信公众号具体的 https://wanandroid.com/wxarticle/list/408/1/json
  void getChildSubList(int page, int id, Function callback) {
    DioManager.singleton.dio
        .get(Api.WX_ARTICLE_LIST +
            id.toString()+"/" +page.toString()+"/json" )
        .then((response) {
      callback(SubChildModel.fromJsonMap(response.data));
    });
  }
}
