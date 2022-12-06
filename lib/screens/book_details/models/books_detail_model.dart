import 'dart:isolate';

/// row : {"id":11,"image":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-07-57-36-0622663b07bb00.jpeg","attachments":[{"url":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-04-21-062266545eb845.pdf"}],"price":"12.00","currency":"دينار","published_at":"2022-03-05","title":"الطالب العبقري","body":"<p style=\"text-align: right;\">هذا الكتاب به طرق وخطوات إذا اتبعتها تظهر عبقريتك وتبدع فى شتى أمور حياتك والكتاب لابقتصر من اسمه فقط للطلبة فكل انسان هو طالب في مدرسة الحياة الكتاب دليل متكامل لمن يريد النجاح في هذه المدرسة</p>"}

class BooksDetailModel {
  book_details? book_details_data;

  book_details? get row => book_details_data;

  BooksDetailModel({book_details? row}) {
    book_details_data = row;
  }

  BooksDetailModel.fromJson(dynamic json) {
    book_details_data =
        json['row'] != null ? book_details.fromJson(json['row']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (book_details_data != null) {
      map['row'] = book_details_data?.toJson();
    }
    return map;
  }
}

/// id : 11
/// image : "https://api-istchrat.mazadak.net/uploads/books/2022-03-07-07-57-36-0622663b07bb00.jpeg"
/// attachments : [{"url":"https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-04-21-062266545eb845.pdf"}]
/// price : "12.00"
/// currency : "دينار"
/// published_at : "2022-03-05"
/// title : "الطالب العبقري"
/// body : "<p style=\"text-align: right;\">هذا الكتاب به طرق وخطوات إذا اتبعتها تظهر عبقريتك وتبدع فى شتى أمور حياتك والكتاب لابقتصر من اسمه فقط للطلبة فكل انسان هو طالب في مدرسة الحياة الكتاب دليل متكامل لمن يريد النجاح في هذه المدرسة</p>"

class book_details {
  int? _id;
  String? _image;
  List<Attachments>? _attachments;
  String? _price;
  String? _currency;
  String? _publishedAt;
  String? _title;
  String? _body;
  bool? _isFavourite;
  bool? _is_purchased;
  String? _lecturer_name;
  String?_category_name;
  int? _sold;
  int? _pages;


  int? get id => _id;
  int?get sold =>_sold;
  String? get image => _image;
  String? get category_name => _category_name;
  String? get lecturer_name => _lecturer_name;
  List<Attachments>? get attachments => _attachments;
  String? get price => _price;
  String? get currency => _currency;
  String? get publishedAt => _publishedAt;
  String? get title => _title;
  String? get body => _body;
  bool? get isFavourite => _isFavourite;
  bool? get is_purchased => _is_purchased;
  int? get pages => _pages;

  set isFav(bool bool) => _isFavourite = bool;

  book_details(
      {int? id,
        int? sold,
      String? image,  String? lecturer_name,String? category_name,
      List<Attachments>? attachments,
      String? price,
      String? currency,
      String? publishedAt,
      String? title,
        bool? isFavourite,bool? is_purchased,
        int? pages,
      String? body}) {
    _id = id;
    _image = image;
    _category_name=category_name;
    _attachments = attachments;
    _price = price;
    _currency = currency;
    _publishedAt = publishedAt;
    _title = title;
    _body = body;
    _isFavourite = isFavourite;
    _is_purchased=is_purchased;
    _sold=sold;
    _lecturer_name=lecturer_name;
    _pages = pages;
  }

  book_details.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    if (json['attachments'] != null) {
      _attachments = [];
      json['attachments'].forEach((v) {
        _attachments?.add(Attachments.fromJson(v));
      });
    }
    _price = json['price'];
    _category_name=json['category_name'];
    _currency = json['currency'];
    _publishedAt = json['published_at'];
    _title = json['title'];
    _lecturer_name=json['lecturer_name'];
    _sold=json['sold'];
    _body = json['body'];
    _isFavourite = json['is_favorite'];
    _is_purchased = json['is_purchased'];
    _pages = json['pages_no'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    if (_attachments != null) {
      map['attachments'] = _attachments?.map((v) => v.toJson()).toList();
    }
    map['price'] = _price;
    map['currency'] = _currency;
    map['published_at'] = _publishedAt;
    map['title'] = _title;
    map['title'] = _title;
    map['body'] = _body;
    map['sold'] = _sold;
    map['is_purchased'] = _is_purchased;
    map['lecturer_name'] = _lecturer_name;
    map['category_name']=_category_name;
    return map;
  }
}

/// url : "https://api-istchrat.mazadak.net/uploads/books/2022-03-07-08-04-21-062266545eb845.pdf"

class Attachments {
  String? _url;

  String? get url => _url;

  Attachments({String? url}) {
    _url = url;
  }

  Attachments.fromJson(dynamic json) {
    _url = json['url'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['url'] = _url;
    return map;
  }
}
