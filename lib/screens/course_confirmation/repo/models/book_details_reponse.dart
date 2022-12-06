class BookDetailsReponse {
  Row? _row;

  Row? get row => _row;

  BookDetailsReponse({
      Row? row}){
    _row = row;
}

  BookDetailsReponse.fromJson(dynamic json) {
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
  Book? _book;
  String? _bookPrice;
  String? _taxFee;
  String? _totalGrand;
  String? _currency;

  Book? get book => _book;
  String? get bookPrice => _bookPrice;
  String? get taxFee => _taxFee;
  String? get totalGrand => _totalGrand;
  String? get currency => _currency;

  Row({
      Book? book, 
      String? bookPrice, 
      String? taxFee, 
      String? totalGrand, 
      String? currency}){
    _book = book;
    _bookPrice = bookPrice;
    _taxFee = taxFee;
    _totalGrand = totalGrand;
    _currency = currency;
}

  Row.fromJson(dynamic json) {
    _book = json['book'] != null ? Book.fromJson(json['book']) : null;
    _bookPrice = json['bookPrice'];
    _taxFee = json['taxFee'];
    _totalGrand = json['totalGrand'];
    _currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_book != null) {
      map['book'] = _book?.toJson();
    }
    map['bookPrice'] = _bookPrice;
    map['taxFee'] = _taxFee;
    map['totalGrand'] = _totalGrand;
    map['currency'] = _currency;
    return map;
  }

}

class Book {
  int? _id;
  dynamic? _image;
  String? _lecturerName;
  List<dynamic>? _attachments;
  String? _price;
  String? _currency;
  String? _publishedAt;
  String? _title;
  String? _body;
  String? _categoryName;
  int? _sold;
  bool? _isFavorite;
  bool? _isPurchased;

  int? get id => _id;
  dynamic? get image => _image;
  String? get lecturerName => _lecturerName;
  List<dynamic>? get attachments => _attachments;
  String? get price => _price;
  String? get currency => _currency;
  String? get publishedAt => _publishedAt;
  String? get title => _title;
  String? get body => _body;
  String? get categoryName => _categoryName;
  int? get sold => _sold;
  bool? get isFavorite => _isFavorite;
  bool? get isPurchased => _isPurchased;

  Book({
      int? id, 
      dynamic? image, 
      String? lecturerName, 
      List<dynamic>? attachments, 
      String? price, 
      String? currency, 
      String? publishedAt, 
      String? title, 
      String? body, 
      String? categoryName, 
      int? sold, 
      bool? isFavorite, 
      bool? isPurchased}){
    _id = id;
    _image = image;
    _lecturerName = lecturerName;
    _attachments = attachments;
    _price = price;
    _currency = currency;
    _publishedAt = publishedAt;
    _title = title;
    _body = body;
    _categoryName = categoryName;
    _sold = sold;
    _isFavorite = isFavorite;
    _isPurchased = isPurchased;
}

  Book.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _lecturerName = json['lecturer_name'];
    if (json['attachments'] != null) {
      _attachments = [];
    }
    _price = json['price'];
    _currency = json['currency'];
    _publishedAt = json['published_at'];
    _title = json['title'];
    _body = json['body'];
    _categoryName = json['category_name'];
    _sold = json['sold'];
    _isFavorite = json['is_favorite'];
    _isPurchased = json['is_purchased'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['lecturer_name'] = _lecturerName;
    if (_attachments != null) {
      map['attachments'] = _attachments?.map((v) => v.toJson()).toList();
    }
    map['price'] = _price;
    map['currency'] = _currency;
    map['published_at'] = _publishedAt;
    map['title'] = _title;
    map['body'] = _body;
    map['category_name'] = _categoryName;
    map['sold'] = _sold;
    map['is_favorite'] = _isFavorite;
    map['is_purchased'] = _isPurchased;
    return map;
  }

}