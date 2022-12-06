/// data : {"message":"","sliders":[{"url":"https://api-istchrat.mazadak.net/uploads/lecturers/2022-03-07-07-42-18-06226601a80886.png"}],"onlineCourses":[{"id":11,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-45-55-062266f03cbcda.png","date":"March, 08 2022","time":"07:00 م","title":"التسويق الالكتروني","price":"10.00","currency":"دينار","is_live_now":false,"is_favorite":false,"is_purchased":false},{"id":10,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-51-55-06226706b0e0ad.jpeg","date":"March, 08 2022","time":"08:00 م","title":"العمل الحر عبر الانترنت","price":"10.00","currency":"دينار","is_live_now":false,"is_favorite":false,"is_purchased":false},{"id":9,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-53-54-0622670e27d05c.png","date":"March, 08 2022","time":"09:00 م","title":"ماتلاب","price":"10.00","currency":"دينار","is_live_now":false,"is_favorite":false,"is_purchased":false}],"offlineCourses":[{"id":11,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-09-30-27-062267973afb3a.png","date":"March, 07 2022","time":"07:00 م","title":"السلامة والصحة المهنية","price":"10.00","currency":"دينار","is_favorite":false,"is_purchased":false},{"id":10,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-09-36-25-062267ad9b38a6.jpeg","date":"March, 07 2022","time":"09:00 م","title":"إدارة الجودة الشاملة","price":"50.00","currency":"دينار","is_favorite":false,"is_purchased":false},{"id":9,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-09-40-12-062267bbc7a866.jpeg","date":"March, 07 2022","time":"10:00 م","title":"6 سيجما","price":"100.00","currency":"دينار","is_favorite":false,"is_purchased":false}],"booksAuthors":[{"id":11,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-07-57-36-0622663b07bb00.jpeg","title":"الطالب العبقري","price":"12.00","currency":"دينار","is_favorite":false,"is_purchased":false},{"id":10,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-06-20-0622665bcdc47f.jpeg","title":"إدارة الوقت من المنظور الإسلامي والإداري","price":"12.00","currency":"دينار","is_favorite":false,"is_purchased":false},{"id":9,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-11-38-0622666fa0422a.png","title":"كيف تقرأ كتابا","price":"12.00","currency":"دينار","is_favorite":false,"is_purchased":false}]}

class HomeModel {
  Data? _data;

  Data? get data => _data;

  HomeModel({Data? data}) {
    _data = data;
  }

  HomeModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// message : ""
/// sliders : [{"url":"https://api-istchrat.mazadak.net/uploads/lecturers/2022-03-07-07-42-18-06226601a80886.png"}]
/// onlineCourses : [{"id":11,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-45-55-062266f03cbcda.png","date":"March, 08 2022","time":"07:00 م","title":"التسويق الالكتروني","price":"10.00","currency":"دينار","is_live_now":false,"is_favorite":false,"is_purchased":false},{"id":10,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-51-55-06226706b0e0ad.jpeg","date":"March, 08 2022","time":"08:00 م","title":"العمل الحر عبر الانترنت","price":"10.00","currency":"دينار","is_live_now":false,"is_favorite":false,"is_purchased":false},{"id":9,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-53-54-0622670e27d05c.png","date":"March, 08 2022","time":"09:00 م","title":"ماتلاب","price":"10.00","currency":"دينار","is_live_now":false,"is_favorite":false,"is_purchased":false}]
/// offlineCourses : [{"id":11,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-09-30-27-062267973afb3a.png","date":"March, 07 2022","time":"07:00 م","title":"السلامة والصحة المهنية","price":"10.00","currency":"دينار","is_favorite":false,"is_purchased":false},{"id":10,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-09-36-25-062267ad9b38a6.jpeg","date":"March, 07 2022","time":"09:00 م","title":"إدارة الجودة الشاملة","price":"50.00","currency":"دينار","is_favorite":false,"is_purchased":false},{"id":9,"image":"https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-09-40-12-062267bbc7a866.jpeg","date":"March, 07 2022","time":"10:00 م","title":"6 سيجما","price":"100.00","currency":"دينار","is_favorite":false,"is_purchased":false}]
/// booksAuthors : [{"id":11,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-07-57-36-0622663b07bb00.jpeg","title":"الطالب العبقري","price":"12.00","currency":"دينار","is_favorite":false,"is_purchased":false},{"id":10,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-06-20-0622665bcdc47f.jpeg","title":"إدارة الوقت من المنظور الإسلامي والإداري","price":"12.00","currency":"دينار","is_favorite":false,"is_purchased":false},{"id":9,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-11-38-0622666fa0422a.png","title":"كيف تقرأ كتابا","price":"12.00","currency":"دينار","is_favorite":false,"is_purchased":false}]

class Data {
  String? _message;
  List<Sliders>? _sliders;
  List<OnlineCourses>? _onlineCourses;
  List<OfflineCourses>? _offlineCourses;
  List<BooksAuthors>? _booksAuthors;
  List<Consultation>? _consultations;

  String? get message => _message;

  List<Sliders>? get sliders => _sliders;

  List<OnlineCourses>? get onlineCourses => _onlineCourses;

  List<OfflineCourses>? get offlineCourses => _offlineCourses;

  List<BooksAuthors>? get booksAuthors => _booksAuthors;

  List<Consultation>? get consultations => _consultations;

  Data(
      {String? message,
      List<Sliders>? sliders,
      List<OnlineCourses>? onlineCourses,
      List<OfflineCourses>? offlineCourses,
      List<BooksAuthors>? booksAuthors}) {
    _message = message;
    _sliders = sliders;
    _onlineCourses = onlineCourses;
    _offlineCourses = offlineCourses;
    _booksAuthors = booksAuthors;
  }

  Data.fromJson(dynamic json) {
    _message = json['message'];
    if (json['sliders'] != null) {
      _sliders = [];
      json['sliders'].forEach((v) {
        _sliders?.add(Sliders.fromJson(v));
      });
    }
    if (json['onlineCourses'] != null) {
      _onlineCourses = [];
      json['onlineCourses'].forEach((v) {
        _onlineCourses?.add(OnlineCourses.fromJson(v));
      });
    }
    if (json['offlineCourses'] != null) {
      _offlineCourses = [];
      json['offlineCourses'].forEach((v) {
        _offlineCourses?.add(OfflineCourses.fromJson(v));
      });
    }
    if (json['booksAuthors'] != null) {
      print(json['booksAuthors'].toString() + "test");
      _booksAuthors = [];
      json['booksAuthors'].forEach((v) {
        _booksAuthors?.add(BooksAuthors.fromJson(v));
      });
    }
    if (json['consultations'] != null) {
      _consultations = [];
      json['consultations'].forEach((v) {
        _consultations?.add(Consultation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['message'] = _message;
    if (_sliders != null) {
      map['sliders'] = _sliders?.map((v) => v.toJson()).toList();
    }
    if (_onlineCourses != null) {
      map['onlineCourses'] = _onlineCourses?.map((v) => v.toJson()).toList();
    }
    if (_offlineCourses != null) {
      map['offlineCourses'] = _offlineCourses?.map((v) => v.toJson()).toList();
    }
    if (_booksAuthors != null) {
      map['booksAuthors'] = _booksAuthors?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 11
/// image : "https://api-istchrat.mazadak.net/uploads/books/2022-03-07-07-57-36-0622663b07bb00.jpeg"
/// title : "الطالب العبقري"
/// price : "12.00"
/// currency : "دينار"
/// is_favorite : false
/// is_purchased : false

class BooksAuthors {
  int? _id;
  String? _image;
  String? _title;
  String? _price;
  String? _currency;
  bool? _isFavorite;
  bool? _isPurchased;
  String? _publishedAt;

  int? get id => _id;

  String? get image => _image;

  String? get title => _title;

  String? get price => _price;

  String? get currency => _currency;

  bool? get isFavorite => _isFavorite;

  bool? get isPurchased => _isPurchased;

  String? get publishedAt => _publishedAt;

  set isFave(bool bool) => _isFavorite = bool;

  BooksAuthors(
      {int? id,
      String? image,
      String? title,
      String? price,
      String? currency,
      bool? isFavorite,
      String? publishedAt,
      bool? isPurchased}) {
    _id = id;
    _image = image;
    _title = title;
    _price = price;
    _currency = currency;
    _isFavorite = isFavorite;
    _isPurchased = isPurchased;
    _publishedAt = publishedAt;
  }

  BooksAuthors.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _title = json['title'];
    _price = json['price'];
    _currency = json['currency'];
    _isFavorite = json['is_favorite'];
    _isPurchased = json['is_purchased'];
    _publishedAt = json['published_at'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['title'] = _title;
    map['price'] = _price;
    map['currency'] = _currency;
    map['is_favorite'] = _isFavorite;
    map['is_purchased'] = _isPurchased;
    return map;
  }
}

/// id : 11
/// image : "https://api-istchrat.mazadak.net/uploads/offlineCourses/2022-03-07-09-30-27-062267973afb3a.png"
/// date : "March, 07 2022"
/// time : "07:00 م"
/// title : "السلامة والصحة المهنية"
/// price : "10.00"
/// currency : "دينار"
/// is_favorite : false
/// is_purchased : false

class OfflineCourses {
  int? _id;
  String? _image;
  String? _date;
  String? _time;
  String? _title;
  String? _price;
  String? _currency;
  bool? _isFavorite;
  bool? _isPurchased;

  int? get id => _id;

  String? get image => _image;

  String? get date => _date;

  String? get time => _time;

  String? get title => _title;

  String? get price => _price;

  String? get currency => _currency;

  bool? get isFavorite => _isFavorite;

  bool? get isPurchased => _isPurchased;

  set isFave(bool bool) => _isFavorite = bool;

  OfflineCourses(
      {int? id,
      String? image,
      String? date,
      String? time,
      String? title,
      String? price,
      String? currency,
      bool? isFavorite,
      bool? isPurchased}) {
    _id = id;
    _image = image;
    _date = date;
    _time = time;
    _title = title;
    _price = price;
    _currency = currency;
    _isFavorite = isFavorite;
    _isPurchased = isPurchased;
  }

  OfflineCourses.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _date = json['date'];
    _time = json['time'];
    _title = json['title'];
    _price = json['price'];
    _currency = json['currency'];
    _isFavorite = json['is_favorite'];
    _isPurchased = json['is_purchased'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['date'] = _date;
    map['time'] = _time;
    map['title'] = _title;
    map['price'] = _price;
    map['currency'] = _currency;
    map['is_favorite'] = _isFavorite;
    map['is_purchased'] = _isPurchased;
    return map;
  }
}

/// id : 11
/// image : "https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-45-55-062266f03cbcda.png"
/// date : "March, 08 2022"
/// time : "07:00 م"
/// title : "التسويق الالكتروني"
/// price : "10.00"
/// currency : "دينار"
/// is_live_now : false
/// is_favorite : false
/// is_purchased : false

class OnlineCourses {
  int? _id;
  String? _image;
  String? _date;
  String? _time;
  String? _title;
  String? _price;
  String? _currency;
  bool? _isLiveNow;
  bool? _isFavorite;
  bool? _isPurchased;

  int? get id => _id;

  String? get image => _image;

  String? get date => _date;

  String? get time => _time;

  String? get title => _title;

  String? get price => _price;

  String? get currency => _currency;

  bool? get isLiveNow => _isLiveNow;

  bool? get isFavorite => _isFavorite;

  bool? get isPurchased => _isPurchased;

  set isFave(bool bool) => _isFavorite = bool;

  OnlineCourses(
      {int? id,
      String? image,
      String? date,
      String? time,
      String? title,
      String? price,
      String? currency,
      bool? isLiveNow,
      bool? isFavorite,
      bool? isPurchased}) {
    _id = id;
    _image = image;
    _date = date;
    _time = time;
    _title = title;
    _price = price;
    _currency = currency;
    _isLiveNow = isLiveNow;
    _isFavorite = isFavorite;
    _isPurchased = isPurchased;
  }

  OnlineCourses.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _date = json['date'];
    _time = json['time'];
    _title = json['title'];
    _price = json['price'];
    _currency = json['currency'];
    _isLiveNow = json['is_live_now'];
    _isFavorite = json['is_favorite'];
    _isPurchased = json['is_purchased'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['date'] = _date;
    map['time'] = _time;
    map['title'] = _title;
    map['price'] = _price;
    map['currency'] = _currency;
    map['is_live_now'] = _isLiveNow;
    map['is_favorite'] = _isFavorite;
    map['is_purchased'] = _isPurchased;
    return map;
  }
}

/// url : "https://api-istchrat.mazadak.net/uploads/lecturers/2022-03-07-07-42-18-06226601a80886.png"

class Sliders {
  String? _url;
  String? _modelType;
  int? _modelID;

  String? get url => _url;

  String? get modelType => _modelType;

  int? get modelID => _modelID;

  Sliders({String? url, String? type, int? id}) {
    _url = url;
    _modelID = id;
    _modelType = type;
  }

  Sliders.fromJson(dynamic json) {
    _url = json['url'];
    _modelType = json['model_type'];
    _modelID = json['model_id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['url'] = _url;
    return map;
  }
}

class Consultation {
  String? _key;
  bool? _value;

  bool? get value => _value;

  String? get key => _key;

  Consultation.fromJson(dynamic json) {
    _key = json['key'];
    _value = json['value'];
  }
}
