/// data : {"lecturer":{"image":"https://api-istchrat.mazadak.net/uploads/lecturers/2022-03-07-07-42-18-06226601a7f77a.png","name":"د. مصطفي أبو سعد","position":"أستشاري نفسي وتربوي ومن رواد العالم العربي","university":"جامعة العلوم والإقتصاد"},"current_monthNumber":"03","current_monthName":"مارس","current_dayNumber":"22","current_time":"21:46:14","prices":[{"key":"1","value":"12:00 صباحاٌ"}]}

class QuestionAnswerModel {
  QuestionAnswerModel({
      Data? data,}){
    _data = data;
}

  QuestionAnswerModel.fromJson(dynamic json) {
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

/// lecturer : {"image":"https://api-istchrat.mazadak.net/uploads/lecturers/2022-03-07-07-42-18-06226601a7f77a.png","name":"د. مصطفي أبو سعد","position":"أستشاري نفسي وتربوي ومن رواد العالم العربي","university":"جامعة العلوم والإقتصاد"}
/// current_monthNumber : "03"
/// current_monthName : "مارس"
/// current_dayNumber : "22"
/// current_time : "21:46:14"
/// prices : [{"key":"1","value":"12:00 صباحاٌ"}]

class Data {
  Data({
      Lecturer? lecturer, 
      String? currentMonthNumber, 
      String? currentMonthName, 
      String? currentDayNumber, 
      String? currentTime, 
      List<Prices>? prices,}){
    _lecturer = lecturer;
    _currentMonthNumber = currentMonthNumber;
    _currentMonthName = currentMonthName;
    _currentDayNumber = currentDayNumber;
    _currentTime = currentTime;
    _prices = prices;
}

  Data.fromJson(dynamic json) {
    _lecturer = json['lecturer'] != null ? Lecturer.fromJson(json['lecturer']) : null;
    _currentMonthNumber = json['current_monthNumber'];
    _currentMonthName = json['current_monthName'];
    _currentDayNumber = json['current_dayNumber'];
    _currentTime = json['current_time'];
    if (json['prices'] != null) {
      _prices = [];
      json['prices'].forEach((v) {
        _prices?.add(Prices.fromJson(v));
      });
    }
  }
  Lecturer? _lecturer;
  String? _currentMonthNumber;
  String? _currentMonthName;
  String? _currentDayNumber;
  String? _currentTime;
  List<Prices>? _prices;

  Lecturer? get lecturer => _lecturer;
  String? get currentMonthNumber => _currentMonthNumber;
  String? get currentMonthName => _currentMonthName;
  String? get currentDayNumber => _currentDayNumber;
  String? get currentTime => _currentTime;
  List<Prices>? get prices => _prices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_lecturer != null) {
      map['lecturer'] = _lecturer?.toJson();
    }
    map['current_monthNumber'] = _currentMonthNumber;
    map['current_monthName'] = _currentMonthName;
    map['current_dayNumber'] = _currentDayNumber;
    map['current_time'] = _currentTime;
    if (_prices != null) {
      map['prices'] = _prices?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// key : "1"
/// value : "12:00 صباحاٌ"

class Prices {
  Prices({
      String? key, 
      String? value,}){
    _key = key;
    _value = value;
}

  Prices.fromJson(dynamic json) {
    _key = json['key'];
    _value = json['value'];
  }
  String? _key;
  String? _value;

  String? get key => _key;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['value'] = _value;
    return map;
  }

}

/// image : "https://api-istchrat.mazadak.net/uploads/lecturers/2022-03-07-07-42-18-06226601a7f77a.png"
/// name : "د. مصطفي أبو سعد"
/// position : "أستشاري نفسي وتربوي ومن رواد العالم العربي"
/// university : "جامعة العلوم والإقتصاد"

class Lecturer {
  Lecturer({
      String? image, 
      String? name, 
      String? position, 
      String? university,}){
    _image = image;
    _name = name;
    _position = position;
    _university = university;
}

  Lecturer.fromJson(dynamic json) {
    _image = json['image'];
    _name = json['name'];
    _position = json['position'];
    _university = json['university'];
  }
  String? _image;
  String? _name;
  String? _position;
  String? _university;

  String? get image => _image;
  String? get name => _name;
  String? get position => _position;
  String? get university => _university;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    map['name'] = _name;
    map['position'] = _position;
    map['university'] = _university;
    return map;
  }

}