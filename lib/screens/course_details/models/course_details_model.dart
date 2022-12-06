/// row : {"id":11,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-09-30-27-062267973afb3a.png","course_link":null,"date":"2022-03-07","period":"60","price":"10.00","currency":"دينار","title":"السلامة والصحة المهنية","body":"<p style=\"text-align: right;\">السلامة والصحة المهنية تسحب التطعيم وتختبر معيار الطوارئ المؤقت</p>","is_favorite":false,"is_purchased":false}

class CourseDetailsModel {
  CourseDetail? _row;

  CourseDetail? get row => _row;

  CourseDetailsModel({CourseDetail? row}) {
    _row = row;
  }

  CourseDetailsModel.fromJson(dynamic json) {
    _row = json['row'] != null ? CourseDetail.fromJson(json['row']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_row != null) {
      map['row'] = _row?.toJson();
    }
    return map;
  }
}

/// id : 11
/// image : "https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-09-30-27-062267973afb3a.png"
/// course_link : null
/// date : "2022-03-07"
/// period : "60"
/// price : "10.00"
/// currency : "دينار"
/// title : "السلامة والصحة المهنية"
/// body : "<p style=\"text-align: right;\">السلامة والصحة المهنية تسحب التطعيم وتختبر معيار الطوارئ المؤقت</p>"
/// is_favorite : false
/// is_purchased : false

class CourseDetail {
  int? _id;
  String? _image;
  String? _courseLink;
  String? _intro_link;
  String? _date;
  String? _period;
  String? _price;
  String? _currency;
  String? _title;
  String? _body;
  bool? _isFavorite;
  bool? _isPurchased;
  int? _sold;
  String? _lecturer_name;

  int? get id => _id;
  String? get image => _image;
  String? get courseLink => _courseLink;
  String? get introLink => _intro_link;
  String? get date => _date;
  String? get period => _period;
  String? get price => _price;
  String? get currency => _currency;
  String? get title => _title;
  String? get lecturer_name => _lecturer_name;
  String? get body => _body;
  int? get sold => _sold;
  bool? get isFavorite => _isFavorite;
  bool? get isPurchased => _isPurchased;

  set isFav(bool bool) => _isFavorite = bool;

  CourseDetail(
      {int? id,
      String? image,
      String? courseLink,
        String? introLink,
      String? date,
      String? period,
      String? price,
      String? currency,
      String? title,
      String? body,
      bool? isFavorite,
      String? lecturer_name,
      bool? isPurchased,
      int? sold}) {
    _id = id;
    _intro_link=introLink;
    _sold = sold;
    _image = image;
    _courseLink = courseLink;
    _lecturer_name = lecturer_name;
    _date = date;
    _period = period;
    _price = price;
    _currency = currency;
    _title = title;
    _body = body;
    _isFavorite = isFavorite;
    _isPurchased = isPurchased;
  }

  CourseDetail.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _courseLink = json['course_link'];
    _intro_link = json['intro_link'];
    _date = json['date'];
    _period = json['period'];
    _price = json['price'];
    _currency = json['currency'];
    _title = json['title'];
    _body = json['body'];
    _isFavorite = json['is_favorite'];
    _isPurchased = json['is_purchased'];
    _lecturer_name = json['lecturer_name'];
    _sold = json['sold'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['course_link'] = _courseLink;
    map['intro_link'] = _intro_link;
    map['date'] = _date;
    map['period'] = _period;
    map['price'] = _price;
    map['currency'] = _currency;
    map['title'] = _title;
    map['body'] = _body;
    map['is_favorite'] = _isFavorite;
    map['is_purchased'] = _isPurchased;
    map['lecturer_name'] = _lecturer_name;
    map['sold'] = _sold;
    return map;
  }
}
