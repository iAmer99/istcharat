class VideoListModel {
  Row? _row;

  Row? get row => _row;

  VideoListModel({Row? row}) {
    _row = row;
  }

  VideoListModel.fromJson(dynamic json) {
    _row = json['row'] != null ? Row.fromJson(json['row']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_row != null) {
      map['row'] = _row?.toJson();
    }
    return map;
  }
}

class Row {
  List<VideosList>? _videosList;

  List<VideosList>? get videosList => _videosList;

  Row({List<VideosList>? videosList}) {
    _videosList = videosList;
  }

  Row.fromJson(dynamic json) {
    if (json['other_links'] != null) {
      _videosList = [];
      json['other_links'].forEach((v) {
        _videosList?.add(VideosList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_videosList != null) {
      map['other_links'] = _videosList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class VideosList {
  String? _courseLink;
  String? _title;
  String? _date;

  String? get courseLink => _courseLink;

  String? get title => _title;

  String? get date => _date;

  VideosList({
    String? title,
    String? date,
    String? courseLink,
  }) {
    _courseLink = courseLink;
    _title = title;
    _date = date;
  }

  VideosList.fromJson(dynamic json) {
    _courseLink = json['course_link'];
    _title = json["title"];
    _date = json["date"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['course_link'] = _courseLink;
    return map;
  }
}
