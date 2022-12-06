/// data : {"rows":[{"id":3,"mime_type":"video","image":null,"youtube_link":"https://www.youtube.com/watch?v=p8Y0u9vey6E","title":"إستشاري نفسي وتربوي ومن رواد العالم العربي","body":null},{"id":2,"mime_type":"image","image":"https://api-istchrat.mazadak.net/uploads/splashes/2022-03-07-07-29-54-062265d32ef6b3.png","youtube_link":null,"title":"إستشاري نفسي وتربوي ومن رواد العالم العربي","body":null},{"id":1,"mime_type":"image","image":"https://api-istchrat.mazadak.net/uploads/splashes/2022-03-07-07-30-07-062265d3fbb306.png","youtube_link":null,"title":"إستشاري نفسي وتربوي ومن رواد العالم العربي","body":null}]}

class IntroModel {
  IntroModel({
      Data? data,}){
    _data = data;
}

  IntroModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// rows : [{"id":3,"mime_type":"video","image":null,"youtube_link":"https://www.youtube.com/watch?v=p8Y0u9vey6E","title":"إستشاري نفسي وتربوي ومن رواد العالم العربي","body":null},{"id":2,"mime_type":"image","image":"https://api-istchrat.mazadak.net/uploads/splashes/2022-03-07-07-29-54-062265d32ef6b3.png","youtube_link":null,"title":"إستشاري نفسي وتربوي ومن رواد العالم العربي","body":null},{"id":1,"mime_type":"image","image":"https://api-istchrat.mazadak.net/uploads/splashes/2022-03-07-07-30-07-062265d3fbb306.png","youtube_link":null,"title":"إستشاري نفسي وتربوي ومن رواد العالم العربي","body":null}]

class Data {
  Data({
      List<Rows>? rows,}){
    _rows = rows;
}

  Data.fromJson(dynamic json) {
    if (json['rows'] != null) {
      _rows = [];
      json['rows'].forEach((v) {
        _rows?.add(Rows.fromJson(v));
      });
    }
  }
  List<Rows>? _rows;

  List<Rows>? get rows => _rows;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_rows != null) {
      map['rows'] = _rows?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 3
/// mime_type : "video"
/// image : null
/// youtube_link : "https://www.youtube.com/watch?v=p8Y0u9vey6E"
/// title : "إستشاري نفسي وتربوي ومن رواد العالم العربي"
/// body : null

class Rows {
  Rows({
      int? id, 
      String? mimeType, 
      dynamic image, 
      String? youtubeLink, 
      String? title, 
      dynamic body,}){
    _id = id;
    _mimeType = mimeType;
    _image = image;
    _youtubeLink = youtubeLink;
    _title = title;
    _body = body;
}

  Rows.fromJson(dynamic json) {
    _id = json['id'];
    _mimeType = json['mime_type'];
    _image = json['image'];
    _youtubeLink = json['youtube_link'];
    _title = json['title'];
    _body = json['body'];
  }
  int? _id;
  String? _mimeType;
  dynamic _image;
  String? _youtubeLink;
  String? _title;
  dynamic _body;

  int? get id => _id;
  String? get mimeType => _mimeType;
  dynamic get image => _image;
  String? get youtubeLink => _youtubeLink;
  String? get title => _title;
  dynamic get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mime_type'] = _mimeType;
    map['image'] = _image;
    map['youtube_link'] = _youtubeLink;
    map['title'] = _title;
    map['body'] = _body;
    return map;
  }

}