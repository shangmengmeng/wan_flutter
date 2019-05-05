

class BannerModel {

   List<BannerData> data;
   int errorCode;
   String errorMsg;

	BannerModel(this.data, this.errorCode, this.errorMsg);


	BannerModel.fromJsonMap(Map<String, dynamic> map):
		data = List<BannerData>.from(map["data"].map((it) => BannerData.fromJsonMap(it))),
		errorCode = map["errorCode"],
		errorMsg = map["errorMsg"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['data'] = data != null ?
			this.data.map((v) => v.toJson()).toList()
			: null;
		data['errorCode'] = errorCode;
		data['errorMsg'] = errorMsg;
		return data;
	}
}
class BannerData {

	final String desc;
	final int id;
	final String imagePath;
	final int isVisible;
	final int order;
	final String title;
	final int type;
	final String url;

	BannerData.fromJsonMap(Map<String, dynamic> map):
				desc = map["desc"],
				id = map["id"],
				imagePath = map["imagePath"],
				isVisible = map["isVisible"],
				order = map["order"],
				title = map["title"],
				type = map["type"],
				url = map["url"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['desc'] = desc;
		data['id'] = id;
		data['imagePath'] = imagePath;
		data['isVisible'] = isVisible;
		data['order'] = order;
		data['title'] = title;
		data['type'] = type;
		data['url'] = url;
		return data;
	}
}
