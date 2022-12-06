/// data : {"lecturer":{"image":"https://api-istchrat.mazadak.net/uploads/lecturers/2022-03-07-07-42-18-06226601a7f77a.png","name":"د. مصطفي أبو سعد","position":"أستشاري نفسي وتربوي ومن رواد العالم العربي","university":"جامعة العلوم والإقتصاد"},"current_monthNumber":"03","current_monthName":"مارس","current_dayNumber":"13","current_time":"12:14:47","months":[{"key":"01","value":"يناير"},{"key":"02","value":"فبراير"},{"key":"03","value":"مارس"},{"key":"04","value":"ابريل"},{"key":"05","value":"مايو"},{"key":"06","value":"يونيو"},{"key":"07","value":"يوليو"},{"key":"08","value":"أغسطس"},{"key":"09","value":"سبتمبر"},{"key":"10","value":"أكتوبر"},{"key":"11","value":"نوفمر"},{"key":"12","value":"ديسمبر"}],"days":[{"key":"13","value":"الأحد"},{"key":"14","value":"الأثنين"},{"key":"15","value":"الثلاثاء"},{"key":"16","value":"الأربع"},{"key":"17","value":"الخميس"},{"key":"18","value":"الجمعة"},{"key":"19","value":"السبت"},{"key":"20","value":"الأحد"},{"key":"21","value":"الأثنين"},{"key":"22","value":"الثلاثاء"},{"key":"23","value":"الأربع"},{"key":"24","value":"الخميس"},{"key":"25","value":"الجمعة"},{"key":"26","value":"السبت"},{"key":"27","value":"الأحد"},{"key":"28","value":"الأثنين"},{"key":"29","value":"الثلاثاء"},{"key":"30","value":"الأربع"},{"key":"31","value":"الخميس"}],"times":[{"key":"06:00:00","value":"06:00 صباحاٌ"},{"key":"06:15:00","value":"06:15 صباحاٌ"},{"key":"06:30:00","value":"06:30 صباحاٌ"},{"key":"06:45:00","value":"06:45 صباحاٌ"},{"key":"07:00:00","value":"07:00 صباحاٌ"},{"key":"07:15:00","value":"07:15 صباحاٌ"},{"key":"07:30:00","value":"07:30 صباحاٌ"},{"key":"07:45:00","value":"07:45 صباحاٌ"},{"key":"08:00:00","value":"08:00 صباحاٌ"},{"key":"08:15:00","value":"08:15 صباحاٌ"},{"key":"08:30:00","value":"08:30 صباحاٌ"},{"key":"08:45:00","value":"08:45 صباحاٌ"},{"key":"09:00:00","value":"09:00 صباحاٌ"},{"key":"09:15:00","value":"09:15 صباحاٌ"},{"key":"09:30:00","value":"09:30 صباحاٌ"},{"key":"09:45:00","value":"09:45 صباحاٌ"},{"key":"10:00:00","value":"10:00 صباحاٌ"},{"key":"10:15:00","value":"10:15 صباحاٌ"},{"key":"10:30:00","value":"10:30 صباحاٌ"},{"key":"10:45:00","value":"10:45 صباحاٌ"},{"key":"11:00:00","value":"11:00 صباحاٌ"},{"key":"11:15:00","value":"11:15 صباحاٌ"},{"key":"11:30:00","value":"11:30 صباحاٌ"},{"key":"11:45:00","value":"11:45 صباحاٌ"},{"key":"12:00:00","value":"12:00 مساءاٌ"},{"key":"12:15:00","value":"12:15 مساءاٌ"},{"key":"12:30:00","value":"12:30 مساءاٌ"},{"key":"12:45:00","value":"12:45 مساءاٌ"},{"key":"13:00:00","value":"01:00 مساءاٌ"},{"key":"13:15:00","value":"01:15 مساءاٌ"},{"key":"13:30:00","value":"01:30 مساءاٌ"},{"key":"13:45:00","value":"01:45 مساءاٌ"},{"key":"14:00:00","value":"02:00 مساءاٌ"},{"key":"14:15:00","value":"02:15 مساءاٌ"},{"key":"14:30:00","value":"02:30 مساءاٌ"},{"key":"14:45:00","value":"02:45 مساءاٌ"},{"key":"15:00:00","value":"03:00 مساءاٌ"},{"key":"15:15:00","value":"03:15 مساءاٌ"},{"key":"15:30:00","value":"03:30 مساءاٌ"},{"key":"15:45:00","value":"03:45 مساءاٌ"},{"key":"16:00:00","value":"04:00 مساءاٌ"},{"key":"16:15:00","value":"04:15 مساءاٌ"},{"key":"16:30:00","value":"04:30 مساءاٌ"},{"key":"16:45:00","value":"04:45 مساءاٌ"},{"key":"17:00:00","value":"05:00 مساءاٌ"},{"key":"17:15:00","value":"05:15 مساءاٌ"},{"key":"17:30:00","value":"05:30 مساءاٌ"},{"key":"17:45:00","value":"05:45 مساءاٌ"},{"key":"18:00:00","value":"06:00 مساءاٌ"},{"key":"18:15:00","value":"06:15 مساءاٌ"},{"key":"18:30:00","value":"06:30 مساءاٌ"},{"key":"18:45:00","value":"06:45 مساءاٌ"}],"periods":[{"key":15,"type_value":"دقيقة","price":"10"},{"key":30,"type_value":"دقيقة","price":"15"},{"key":60,"type_value":"دقيقة","price":"20"}]}

class ChatConsultationModel {
  ChatConsultationModel({
      Data? data,}){
    _data = data;
}

  ChatConsultationModel.fromJson(dynamic json) {
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
/// current_dayNumber : "13"
/// current_time : "12:14:47"
/// months : [{"key":"01","value":"يناير"},{"key":"02","value":"فبراير"},{"key":"03","value":"مارس"},{"key":"04","value":"ابريل"},{"key":"05","value":"مايو"},{"key":"06","value":"يونيو"},{"key":"07","value":"يوليو"},{"key":"08","value":"أغسطس"},{"key":"09","value":"سبتمبر"},{"key":"10","value":"أكتوبر"},{"key":"11","value":"نوفمر"},{"key":"12","value":"ديسمبر"}]
/// days : [{"key":"13","value":"الأحد"},{"key":"14","value":"الأثنين"},{"key":"15","value":"الثلاثاء"},{"key":"16","value":"الأربع"},{"key":"17","value":"الخميس"},{"key":"18","value":"الجمعة"},{"key":"19","value":"السبت"},{"key":"20","value":"الأحد"},{"key":"21","value":"الأثنين"},{"key":"22","value":"الثلاثاء"},{"key":"23","value":"الأربع"},{"key":"24","value":"الخميس"},{"key":"25","value":"الجمعة"},{"key":"26","value":"السبت"},{"key":"27","value":"الأحد"},{"key":"28","value":"الأثنين"},{"key":"29","value":"الثلاثاء"},{"key":"30","value":"الأربع"},{"key":"31","value":"الخميس"}]
/// times : [{"key":"06:00:00","value":"06:00 صباحاٌ"},{"key":"06:15:00","value":"06:15 صباحاٌ"},{"key":"06:30:00","value":"06:30 صباحاٌ"},{"key":"06:45:00","value":"06:45 صباحاٌ"},{"key":"07:00:00","value":"07:00 صباحاٌ"},{"key":"07:15:00","value":"07:15 صباحاٌ"},{"key":"07:30:00","value":"07:30 صباحاٌ"},{"key":"07:45:00","value":"07:45 صباحاٌ"},{"key":"08:00:00","value":"08:00 صباحاٌ"},{"key":"08:15:00","value":"08:15 صباحاٌ"},{"key":"08:30:00","value":"08:30 صباحاٌ"},{"key":"08:45:00","value":"08:45 صباحاٌ"},{"key":"09:00:00","value":"09:00 صباحاٌ"},{"key":"09:15:00","value":"09:15 صباحاٌ"},{"key":"09:30:00","value":"09:30 صباحاٌ"},{"key":"09:45:00","value":"09:45 صباحاٌ"},{"key":"10:00:00","value":"10:00 صباحاٌ"},{"key":"10:15:00","value":"10:15 صباحاٌ"},{"key":"10:30:00","value":"10:30 صباحاٌ"},{"key":"10:45:00","value":"10:45 صباحاٌ"},{"key":"11:00:00","value":"11:00 صباحاٌ"},{"key":"11:15:00","value":"11:15 صباحاٌ"},{"key":"11:30:00","value":"11:30 صباحاٌ"},{"key":"11:45:00","value":"11:45 صباحاٌ"},{"key":"12:00:00","value":"12:00 مساءاٌ"},{"key":"12:15:00","value":"12:15 مساءاٌ"},{"key":"12:30:00","value":"12:30 مساءاٌ"},{"key":"12:45:00","value":"12:45 مساءاٌ"},{"key":"13:00:00","value":"01:00 مساءاٌ"},{"key":"13:15:00","value":"01:15 مساءاٌ"},{"key":"13:30:00","value":"01:30 مساءاٌ"},{"key":"13:45:00","value":"01:45 مساءاٌ"},{"key":"14:00:00","value":"02:00 مساءاٌ"},{"key":"14:15:00","value":"02:15 مساءاٌ"},{"key":"14:30:00","value":"02:30 مساءاٌ"},{"key":"14:45:00","value":"02:45 مساءاٌ"},{"key":"15:00:00","value":"03:00 مساءاٌ"},{"key":"15:15:00","value":"03:15 مساءاٌ"},{"key":"15:30:00","value":"03:30 مساءاٌ"},{"key":"15:45:00","value":"03:45 مساءاٌ"},{"key":"16:00:00","value":"04:00 مساءاٌ"},{"key":"16:15:00","value":"04:15 مساءاٌ"},{"key":"16:30:00","value":"04:30 مساءاٌ"},{"key":"16:45:00","value":"04:45 مساءاٌ"},{"key":"17:00:00","value":"05:00 مساءاٌ"},{"key":"17:15:00","value":"05:15 مساءاٌ"},{"key":"17:30:00","value":"05:30 مساءاٌ"},{"key":"17:45:00","value":"05:45 مساءاٌ"},{"key":"18:00:00","value":"06:00 مساءاٌ"},{"key":"18:15:00","value":"06:15 مساءاٌ"},{"key":"18:30:00","value":"06:30 مساءاٌ"},{"key":"18:45:00","value":"06:45 مساءاٌ"}]
/// periods : [{"key":15,"type_value":"دقيقة","price":"10"},{"key":30,"type_value":"دقيقة","price":"15"},{"key":60,"type_value":"دقيقة","price":"20"}]

class Data {
  Data({
      Lecturer? lecturer, 
      String? currentMonthNumber, 
      String? currentMonthName, 
      String? currentDayNumber, 
      String? currentTime, 
      List<Months>? months, 
      List<Days>? days, 
      List<Times>? times, 
      List<Periods>? periods,}){
    _lecturer = lecturer;
    _currentMonthNumber = currentMonthNumber;
    _currentMonthName = currentMonthName;
    _currentDayNumber = currentDayNumber;
    _currentTime = currentTime;
    _months = months;
    _days = days;
    _times = times;
    _periods = periods;
}

  Data.fromJson(dynamic json) {
    _lecturer = json['lecturer'] != null ? Lecturer.fromJson(json['lecturer']) : null;
    _currentMonthNumber = json['current_monthNumber'];
    _currentMonthName = json['current_monthName'];
    _currentDayNumber = json['current_dayNumber'];
    _currentTime = json['current_time'];
    if (json['months'] != null) {
      _months = [];
      json['months'].forEach((v) {
        _months?.add(Months.fromJson(v));
      });
    }
    if (json['days'] != null) {
      _days = [];
      json['days'].forEach((v) {
        _days?.add(Days.fromJson(v));
      });
    }
    if (json['times'] != null) {
      _times = [];
      json['times'].forEach((v) {
        _times?.add(Times.fromJson(v));
      });
    }
    if (json['periods'] != null) {
      _periods = [];
      json['periods'].forEach((v) {
        _periods?.add(Periods.fromJson(v));
      });
    }
  }
  Lecturer? _lecturer;
  String? _currentMonthNumber;
  String? _currentMonthName;
  String? _currentDayNumber;
  String? _currentTime;
  List<Months>? _months;
  List<Days>? _days;
  List<Times>? _times;
  List<Periods>? _periods;

  Lecturer? get lecturer => _lecturer;
  String? get currentMonthNumber => _currentMonthNumber;
  String? get currentMonthName => _currentMonthName;
  String? get currentDayNumber => _currentDayNumber;
  String? get currentTime => _currentTime;
  List<Months>? get months => _months;
  List<Days>? get days => _days;
  List<Times>? get times => _times;
  List<Periods>? get periods => _periods;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_lecturer != null) {
      map['lecturer'] = _lecturer?.toJson();
    }
    map['current_monthNumber'] = _currentMonthNumber;
    map['current_monthName'] = _currentMonthName;
    map['current_dayNumber'] = _currentDayNumber;
    map['current_time'] = _currentTime;
    if (_months != null) {
      map['months'] = _months?.map((v) => v.toJson()).toList();
    }
    if (_days != null) {
      map['days'] = _days?.map((v) => v.toJson()).toList();
    }
    if (_times != null) {
      map['times'] = _times?.map((v) => v.toJson()).toList();
    }
    if (_periods != null) {
      map['periods'] = _periods?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// key : 15
/// type_value : "دقيقة"
/// price : "10"

class Periods {
  Periods({
      int? key, 
      String? typeValue, 
      String? price,}){
    _key = key;
    _typeValue = typeValue;
    _price = price;
}

  Periods.fromJson(dynamic json) {
    _key = json['key'];
    _typeValue = json['type_value'];
    _price = json['price'];
  }
  int? _key;
  String? _typeValue;
  String? _price;

  int? get key => _key;
  String? get typeValue => _typeValue;
  String? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['type_value'] = _typeValue;
    map['price'] = _price;
    return map;
  }

}

/// key : "06:00:00"
/// value : "06:00 صباحاٌ"

class Times {
  Times({
      String? key, 
      String? value,}){
    _key = key;
    _value = value;
}

  Times.fromJson(dynamic json) {
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

/// key : "13"
/// value : "الأحد"

class Days {
  Days({
      String? key, 
      String? value,}){
    _key = key;
    _value = value;
}

  Days.fromJson(dynamic json) {
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

/// key : "01"
/// value : "يناير"

class Months {
  Months({
      String? key, 
      String? value,}){
    _key = key;
    _value = value;
}

  Months.fromJson(dynamic json) {
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