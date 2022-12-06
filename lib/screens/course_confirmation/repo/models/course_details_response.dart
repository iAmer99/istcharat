class CourseDetailsResponse {
  Row? _row;

  Row? get row => _row;

  CourseDetailsResponse({
      Row? row}){
    _row = row;
}

  CourseDetailsResponse.fromJson(dynamic json) {
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
  Course? _course;
  String? _coursePrice;
  String? _taxFee;
  String? _totalGrand;
  String? _currency;

  Course? get course => _course;
  String? get coursePrice => _coursePrice;
  String? get taxFee => _taxFee;
  String? get totalGrand => _totalGrand;
  String? get currency => _currency;

  Row({
      Course? course, 
      String? coursePrice, 
      String? taxFee, 
      String? totalGrand, 
      String? currency}){
    _course = course;
    _coursePrice = coursePrice;
    _taxFee = taxFee;
    _totalGrand = totalGrand;
    _currency = currency;
}

  Row.fromJson(dynamic json) {
    _course = json['course'] != null ? Course.fromJson(json['course']) : null;
    _coursePrice = json['coursePrice'];
    _taxFee = json['taxFee'];
    _totalGrand = json['totalGrand'];
    _currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_course != null) {
      map['course'] = _course?.toJson();
    }
    map['coursePrice'] = _coursePrice;
    map['taxFee'] = _taxFee;
    map['totalGrand'] = _totalGrand;
    map['currency'] = _currency;
    return map;
  }

}

class Course {
  int? _id;
  dynamic? _image;
  String? _lecturerName;
  String? _introLink;
  dynamic? _courseLink;
  dynamic? _otherLinks;
  String? _date;
  String? _updatedAt;
  String? _period;
  String? _price;
  String? _currency;
  int? _sold;
  String? _title;
  String? _body;
  bool? _isFavorite;
  bool? _isPurchased;

  int? get id => _id;
  dynamic? get image => _image;
  String? get lecturerName => _lecturerName;
  String? get introLink => _introLink;
  dynamic? get courseLink => _courseLink;
  dynamic? get otherLinks => _otherLinks;
  String? get date => _date;
  String? get updatedAt => _updatedAt;
  String? get period => _period;
  String? get price => _price;
  String? get currency => _currency;
  int? get sold => _sold;
  String? get title => _title;
  String? get body => _body;
  bool? get isFavorite => _isFavorite;
  bool? get isPurchased => _isPurchased;

  Course({
      int? id, 
      dynamic? image, 
      String? lecturerName, 
      String? introLink, 
      dynamic? courseLink, 
      dynamic? otherLinks, 
      String? date, 
      String? updatedAt, 
      String? period, 
      String? price, 
      String? currency, 
      int? sold, 
      String? title, 
      String? body, 
      bool? isFavorite, 
      bool? isPurchased}){
    _id = id;
    _image = image;
    _lecturerName = lecturerName;
    _introLink = introLink;
    _courseLink = courseLink;
    _otherLinks = otherLinks;
    _date = date;
    _updatedAt = updatedAt;
    _period = period;
    _price = price;
    _currency = currency;
    _sold = sold;
    _title = title;
    _body = body;
    _isFavorite = isFavorite;
    _isPurchased = isPurchased;
}

  Course.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _lecturerName = json['lecturer_name'];
    _introLink = json['intro_link'];
    _courseLink = json['course_link'];
    _otherLinks = json['other_links'];
    _date = json['date'];
    _updatedAt = json['updated_at'];
    _period = json['period'];
    _price = json['price'];
    _currency = json['currency'];
    _sold = json['sold'];
    _title = json['title'];
    _body = json['body'];
    _isFavorite = json['is_favorite'];
    _isPurchased = json['is_purchased'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['lecturer_name'] = _lecturerName;
    map['intro_link'] = _introLink;
    map['course_link'] = _courseLink;
    map['other_links'] = _otherLinks;
    map['date'] = _date;
    map['updated_at'] = _updatedAt;
    map['period'] = _period;
    map['price'] = _price;
    map['currency'] = _currency;
    map['sold'] = _sold;
    map['title'] = _title;
    map['body'] = _body;
    map['is_favorite'] = _isFavorite;
    map['is_purchased'] = _isPurchased;
    return map;
  }

}