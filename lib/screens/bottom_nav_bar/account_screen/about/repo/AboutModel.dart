/// data : {"title":"About App","body":"This text is an example of text that can be replaced here"}

class AboutModel {
  AboutModel({
      Data? data,}){
    _data = data;
}

  AboutModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
AboutModel copyWith({  Data? data,
}) => AboutModel(  data: data ?? _data,
);
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// title : "About App"
/// body : "This text is an example of text that can be replaced here"

class Data {
  Data({
      String? title, 
      String? body,}){
    _title = title;
    _body = body;
}

  Data.fromJson(dynamic json) {
    _title = json['title'];
    _body = json['body'];
  }
  String? _title;
  String? _body;
Data copyWith({  String? title,
  String? body,
}) => Data(  title: title ?? _title,
  body: body ?? _body,
);
  String? get title => _title;
  String? get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['body'] = _body;
    return map;
  }

}