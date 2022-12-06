/// data : {"lecturer":{"image":"https://api-istchrat.mazadak.net/uploads/lecturers/2022-04-09-08-03-38-062513ddaf1898.png","name":"د. مصطفي أبو سعد","position":"أستشاري نفسي وتربوي ومن رواد العالم العربي","university":"جامعة العلوم والإقتصاد"},"current_monthNumber":"04","current_monthName":"ابريل","current_dayNumber":"9","current_time":"15:08:42","prices":{"key":"1.00","value":"1.00","currency":"دينار"}}

class QuestionAnswerModel1 {
  QuestionAnswerModel1({
      Data? data,}){
    _data = data;
}

  QuestionAnswerModel1.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
QuestionAnswerModel1 copyWith({  Data? data,
}) => QuestionAnswerModel1(  data: data ?? _data,
);
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// lecturer : {"image":"https://api-istchrat.mazadak.net/uploads/lecturers/2022-04-09-08-03-38-062513ddaf1898.png","name":"د. مصطفي أبو سعد","position":"أستشاري نفسي وتربوي ومن رواد العالم العربي","university":"جامعة العلوم والإقتصاد"}
/// current_monthNumber : "04"
/// current_monthName : "ابريل"
/// current_dayNumber : "9"
/// current_time : "15:08:42"
/// prices : {"key":"1.00","value":"1.00","currency":"دينار"}

class Data {
  Data({
      Lecturer? lecturer, 
      String? currentMonthNumber, 
      String? currentMonthName, 
      String? currentDayNumber, 
      String? currentTime, 
      Prices? prices,}){
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
    _prices = json['prices'] != null ? Prices.fromJson(json['prices']) : null;
  }
  Lecturer? _lecturer;
  String? _currentMonthNumber;
  String? _currentMonthName;
  String? _currentDayNumber;
  String? _currentTime;
  Prices? _prices;
Data copyWith({  Lecturer? lecturer,
  String? currentMonthNumber,
  String? currentMonthName,
  String? currentDayNumber,
  String? currentTime,
  Prices? prices,
}) => Data(  lecturer: lecturer ?? _lecturer,
  currentMonthNumber: currentMonthNumber ?? _currentMonthNumber,
  currentMonthName: currentMonthName ?? _currentMonthName,
  currentDayNumber: currentDayNumber ?? _currentDayNumber,
  currentTime: currentTime ?? _currentTime,
  prices: prices ?? _prices,
);
  Lecturer? get lecturer => _lecturer;
  String? get currentMonthNumber => _currentMonthNumber;
  String? get currentMonthName => _currentMonthName;
  String? get currentDayNumber => _currentDayNumber;
  String? get currentTime => _currentTime;
  Prices? get prices => _prices;

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
      map['prices'] = _prices?.toJson();
    }
    return map;
  }

}

/// key : "1.00"
/// value : "1.00"
/// currency : "دينار"

class Prices {
  Prices({
      String? key, 
      String? value, 
      String? currency,}){
    _key = key;
    _value = value;
    _currency = currency;
}

  Prices.fromJson(dynamic json) {
    _key = json['key'];
    _value = json['value'];
    _currency = json['currency'];
  }
  String? _key;
  String? _value;
  String? _currency;
Prices copyWith({  String? key,
  String? value,
  String? currency,
}) => Prices(  key: key ?? _key,
  value: value ?? _value,
  currency: currency ?? _currency,
);
  String? get key => _key;
  String? get value => _value;
  String? get currency => _currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['value'] = _value;
    map['currency'] = _currency;
    return map;
  }

}

/// image : "https://api-istchrat.mazadak.net/uploads/lecturers/2022-04-09-08-03-38-062513ddaf1898.png"
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
Lecturer copyWith({  String? image,
  String? name,
  String? position,
  String? university,
}) => Lecturer(  image: image ?? _image,
  name: name ?? _name,
  position: position ?? _position,
  university: university ?? _university,
);
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