/// data : {"rows":[{"id":11,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-45-55-062266f03cbcda.png","date":"March, 08 2022","time":"07:00 م","title":"التسويق الالكتروني","price":"10.00"},{"id":10,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-51-55-06226706b0e0ad.jpeg","date":"March, 08 2022","time":"08:00 م","title":"العمل الحر عبر الانترنت","price":"10.00"},{"id":9,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-53-54-0622670e27d05c.png","date":"March, 08 2022","time":"09:00 م","title":"ماتلاب","price":"10.00"},{"id":8,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-59-44-0622672406ad71.png","date":"March, 08 2022","time":"10:00 م","title":"اساسيات الطبخ","price":"15.00"},{"id":7,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-09-04-24-0622673581a1fe.jpeg","date":"March, 08 2022","time":"06:00 م","title":"المهارات الشخصية","price":"5.00"}],"paginate":{"current_page":1,"first_page_url":"https://api-istchrat.mazadak.net/api/v1/onlineCourses?page=1","from":1,"last_page":1,"last_page_url":"https://api-istchrat.mazadak.net/api/v1/onlineCourses?page=1","next_page_url":null,"path":"https://api-istchrat.mazadak.net/api/v1/onlineCourses","per_page":"10","prev_page_url":null,"to":5,"total":5}}

class OnlineModel {
  Data? _data;

  Data? get data => _data;

  OnlineModel({Data? data}) {
    _data = data;
  }

  OnlineModel.fromJson(dynamic json) {
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

/// rows : [{"id":11,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-45-55-062266f03cbcda.png","date":"March, 08 2022","time":"07:00 م","title":"التسويق الالكتروني","price":"10.00"},{"id":10,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-51-55-06226706b0e0ad.jpeg","date":"March, 08 2022","time":"08:00 م","title":"العمل الحر عبر الانترنت","price":"10.00"},{"id":9,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-53-54-0622670e27d05c.png","date":"March, 08 2022","time":"09:00 م","title":"ماتلاب","price":"10.00"},{"id":8,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-59-44-0622672406ad71.png","date":"March, 08 2022","time":"10:00 م","title":"اساسيات الطبخ","price":"15.00"},{"id":7,"image":"https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-09-04-24-0622673581a1fe.jpeg","date":"March, 08 2022","time":"06:00 م","title":"المهارات الشخصية","price":"5.00"}]
/// paginate : {"current_page":1,"first_page_url":"https://api-istchrat.mazadak.net/api/v1/onlineCourses?page=1","from":1,"last_page":1,"last_page_url":"https://api-istchrat.mazadak.net/api/v1/onlineCourses?page=1","next_page_url":null,"path":"https://api-istchrat.mazadak.net/api/v1/onlineCourses","per_page":"10","prev_page_url":null,"to":5,"total":5}

class Data {
  List<onlinecourses>? onlineList;
  Paginate? _paginate;

  List<onlinecourses>? get rows => onlineList;
  Paginate? get paginate => _paginate;

  Data({List<onlinecourses>? rows, Paginate? paginate}) {
    onlineList = rows;
    _paginate = paginate;
  }

  Data.fromJson(dynamic json) {
    if (json['rows'] != null) {
      onlineList = [];
      json['rows'].forEach((v) {
        onlineList?.add(onlinecourses.fromJson(v));
      });
    }
    _paginate =
        json['paginate'] != null ? Paginate.fromJson(json['paginate']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (onlineList != null) {
      map['rows'] = onlineList?.map((v) => v.toJson()).toList();
    }
    if (_paginate != null) {
      map['paginate'] = _paginate?.toJson();
    }
    return map;
  }
}

/// current_page : 1
/// first_page_url : "https://api-istchrat.mazadak.net/api/v1/onlineCourses?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://api-istchrat.mazadak.net/api/v1/onlineCourses?page=1"
/// next_page_url : null
/// path : "https://api-istchrat.mazadak.net/api/v1/onlineCourses"
/// per_page : "10"
/// prev_page_url : null
/// to : 5
/// total : 5

class Paginate {
  int? _currentPage;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  dynamic? _nextPageUrl;
  String? _path;
  String? _perPage;
  dynamic? _prevPageUrl;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  dynamic? get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  String? get perPage => _perPage;
  dynamic? get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

  Paginate(
      {int? currentPage,
      String? firstPageUrl,
      int? from,
      int? lastPage,
      String? lastPageUrl,
      dynamic? nextPageUrl,
      String? path,
      String? perPage,
      dynamic? prevPageUrl,
      int? to,
      int? total}) {
    _currentPage = currentPage;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
  }

  Paginate.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }
}

/// id : 11
/// image : "https://api-istchrat.mazadak.net/uploads/onlineCourses/2022-03-07-08-45-55-062266f03cbcda.png"
/// date : "March, 08 2022"
/// time : "07:00 م"
/// title : "التسويق الالكتروني"
/// price : "10.00"

class onlinecourses {
  int? _id;
  String? _image;
  String? _date;
  String? _time;
  String? _title;
  String? _price;
  String? currency;
  bool? is_favorite;
  bool? is_purchased;
  bool? is_live_now;

  int? get id => _id;
  String? get image => _image;
  String? get date => _date;
  String? get time => _time;
  String? get title => _title;
  String? get price => _price;

  onlinecourses(
      {int? id,
      String? image,
      String? date,
      String? time,
      String? title,
      String? price,
      String? currency,
      bool? is_favorite,
      bool? is_purchased,
      bool?is_live_now}) {
    _id = id;
    _image = image;
    _date = date;
    _time = time;
    _title = title;
    _price = price;

    this.currency;
    this.is_favorite;
    this.is_purchased;
    this.is_live_now;
  }

  onlinecourses.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _date = json['date'];
    _time = json['time'];
    _title = json['title'];
    _price = json['price'];
    currency = json["currency"];
    is_favorite = json["is_favorite"];
    is_purchased = json["is_purchased"];
    is_live_now = json["is_live_now"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['date'] = _date;
    map['time'] = _time;
    map['title'] = _title;
    map['price'] = _price;
    map['is_favorite'] = is_favorite;
    map['is_purchased'] = is_purchased;
    map['is_live_now'] = is_live_now;
    map['currency'] = currency;

    return map;
  }
}
