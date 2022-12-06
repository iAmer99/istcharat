/// row : {"id":11,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-45-55-062266f03cbcda.png","course_link":null,"date":"2022-03-08","time":"19:00:00","period":"480","price":"10.00","currency":"دينار","title":"التسويق الالكتروني","body":"<p style=\"text-align: right;\">تسويق المنتجات أو الخدمات باستخدام التكنولوجيا الرقمية، كالإنترنت والهواتف المحمولة</p>","is_favorite":false,"is_purchased":false}

class Online_details_model {
  OnlineDetailsdata? online_details_data;

  OnlineDetailsdata? get row => online_details_data;

  Online_details_model({OnlineDetailsdata? row}) {
    online_details_data = row;
  }

  Online_details_model.fromJson(dynamic json) {
    online_details_data =
        json['row'] != null ? OnlineDetailsdata.fromJson(json['row']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (online_details_data != null) {
      map['row'] = online_details_data?.toJson();
    }
    return map;
  }
}

/// id : 11
/// image : "https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-45-55-062266f03cbcda.png"
/// course_link : null
/// date : "2022-03-08"
/// time : "19:00:00"
/// period : "480"
/// price : "10.00"
/// currency : "دينار"
/// title : "التسويق الالكتروني"
/// body : "<p style=\"text-align: right;\">تسويق المنتجات أو الخدمات باستخدام التكنولوجيا الرقمية، كالإنترنت والهواتف المحمولة</p>"
/// is_favorite : false
/// is_purchased : false

class OnlineDetailsdata {
  int? _id;
  String? _image;
  String? _courseLink;
  String? _intro_link;
  String? _date;
  String? _time;
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
  int? get sold =>_sold;
  String? get image => _image;
  String? get courseLink => _courseLink;
  String? get introLink => _intro_link;
  String? get date => _date;
  String? get time => _time;
  String? get period => _period;
  String? get price => _price;
  String? get currency => _currency;
  String? get title => _title;
  String? get lecturer_name => _lecturer_name;
  String? get body => _body;
  bool? get isFavorite => _isFavorite;
  bool? get isPurchased => _isPurchased;

  set isFav(bool bool)=> _isFavorite = bool;

  OnlineDetailsdata(
      {int? id,
      String? image,
      String? courseLink,
        String? introLink,
      String? date,
        int?sold,
      String? time,
      String? period,
      String? price,
      String? currency,
      String? title,
      String? body,
      String? lecturer_name,
      bool? isFavorite,
      bool? isPurchased}) {
    _id = id;
    _image = image;
    _courseLink = courseLink;
    _intro_link=introLink;
    _sold=sold;
    _lecturer_name = lecturer_name;
    _date = date;
    _time = time;
    _period = period;
    _price = price;
    _currency = currency;
    _title = title;
    _body = body;
    _isFavorite = isFavorite;
    _isPurchased = isPurchased;
  }

  OnlineDetailsdata.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _courseLink = json['course_link'];
    _intro_link = json['intro_link'];
    _date = json['date'];
    _time = json['time'];
    _period = json['period'];
    _price = json['price'];
    _currency = json['currency'];
    _title = json['title'];
    _body = json['body'];
    _sold = json['sold'];
    _isFavorite = json['is_favorite'];
    _isPurchased = json['is_purchased'];
    _lecturer_name = json['lecturer_name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['course_link'] = _courseLink;
    map['intro_link'] = _intro_link;
    map['date'] = _date;
    map['time'] = _time;
    map['period'] = _period;
    map['price'] = _price;
    map['currency'] = _currency;
    map['title'] = _title;
    map['body'] = _body;
    map['is_favorite'] = _isFavorite;
    map['is_purchased'] = _isPurchased;
    map['sold'] = _sold;
    map['lecturer_name'] = _lecturer_name;
    return map;
  }
}
