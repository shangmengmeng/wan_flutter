

class ProjectDetailModel {

	ProjectDetailData data;
  int errorCode;
  String errorMsg;

	ProjectDetailModel.fromJsonMap(Map<String, dynamic> map): 
		data = ProjectDetailData.fromJsonMap(map["data"]),
		errorCode = map["errorCode"],
		errorMsg = map["errorMsg"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
			data['data'] = this.data.toJson();
		}
		data['errorCode'] = this.errorCode;
		data['errorMsg'] = this.errorMsg;
		return data;
	}
}


class ProjectDetailData {

	int curPage;
	List<ProjectDatas> datas;
	int offset;
	bool over;
	int pageCount;
	int size;
	int total;

	ProjectDetailData.fromJsonMap(Map<String, dynamic> map):
				curPage = map["curPage"],
				datas = List<ProjectDatas>.from(map["datas"].map((it) => ProjectDatas.fromJsonMap(it))),
	offset = map["offset"],
	over = map["over"],
	pageCount = map["pageCount"],
	size = map["size"],
	total = map["total"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['curPage'] = curPage;
		data['datas'] = datas != null ?
		this.datas.map((v) => v.toJson()).toList()
				: null;
		data['offset'] = offset;
		data['over'] = over;
		data['pageCount'] = pageCount;
		data['size'] = size;
		data['total'] = total;
		return data;
	}
}


class ProjectDatas {

	String apkLink;
	String author;
	int chapterId;
	String chapterName;
	bool collect;
	int courseId;
	String desc;
	String envelopePic;
	bool fresh;
	int id;
	String link;
	String niceDate;
	String origin;
	String prefix;
	String projectLink;
	int publishTime;
	int superChapterId;
	String superChapterName;
	List<Tags> tags;
	String title;
	int type;
	int userId;
	int visible;
	int zan;

	ProjectDatas.fromJsonMap(Map<String, dynamic> map):
				apkLink = map["apkLink"],
				author = map["author"],
				chapterId = map["chapterId"],
				chapterName = map["chapterName"],
				collect = map["collect"],
				courseId = map["courseId"],
				desc = map["desc"],
				envelopePic = map["envelopePic"],
				fresh = map["fresh"],
				id = map["id"],
				link = map["link"],
				niceDate = map["niceDate"],
				origin = map["origin"],
				prefix = map["prefix"],
				projectLink = map["projectLink"],
				publishTime = map["publishTime"],
				superChapterId = map["superChapterId"],
				superChapterName = map["superChapterName"],
				tags = List<Tags>.from(map["tags"].map((it) => Tags.fromJsonMap(it))),
	title = map["title"],
	type = map["type"],
	userId = map["userId"],
	visible = map["visible"],
	zan = map["zan"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['apkLink'] = apkLink;
		data['author'] = author;
		data['chapterId'] = chapterId;
		data['chapterName'] = chapterName;
		data['collect'] = collect;
		data['courseId'] = courseId;
		data['desc'] = desc;
		data['envelopePic'] = envelopePic;
		data['fresh'] = fresh;
		data['id'] = id;
		data['link'] = link;
		data['niceDate'] = niceDate;
		data['origin'] = origin;
		data['prefix'] = prefix;
		data['projectLink'] = projectLink;
		data['publishTime'] = publishTime;
		data['superChapterId'] = superChapterId;
		data['superChapterName'] = superChapterName;
		data['tags'] = tags != null ?
		this.tags.map((v) => v.toJson()).toList()
				: null;
		data['title'] = title;
		data['type'] = type;
		data['userId'] = userId;
		data['visible'] = visible;
		data['zan'] = zan;
		return data;
	}
}

class Tags {

	String name;
	String url;

	Tags.fromJsonMap(Map<String, dynamic> map):
				name = map["name"],
				url = map["url"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = name;
		data['url'] = url;
		return data;
	}
}
