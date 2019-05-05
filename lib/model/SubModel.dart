

class SubModel {

  List<SubData> data;
  int errorCode;
  String errorMsg;

	SubModel.fromJsonMap(Map<String, dynamic> map): 
		data = List<SubData>.from(map["data"].map((it) => SubData.fromJsonMap(it))),
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

class SubData {

	List<Object> children;
	int courseId;
	int id;
	String name;
	int order;
	int parentChapterId;
	bool userControlSetTop;
	int visible;

	SubData.fromJsonMap(Map<String, dynamic> map):
				children = map["children"],
				courseId = map["courseId"],
				id = map["id"],
				name = map["name"],
				order = map["order"],
				parentChapterId = map["parentChapterId"],
				userControlSetTop = map["userControlSetTop"],
				visible = map["visible"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['children'] = children;
		data['courseId'] = courseId;
		data['id'] = id;
		data['name'] = name;
		data['order'] = order;
		data['parentChapterId'] = parentChapterId;
		data['userControlSetTop'] = userControlSetTop;
		data['visible'] = visible;
		return data;
	}
}
