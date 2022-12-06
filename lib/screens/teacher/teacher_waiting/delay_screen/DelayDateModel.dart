/// data : {"months":[{"key":"04","value":"ابريل"},{"key":"05","value":"مايو"},{"key":"06","value":"يونيو"},{"key":"07","value":"يوليو"},{"key":"08","value":"أغسطس"},{"key":"09","value":"سبتمبر"},{"key":"10","value":"أكتوبر"},{"key":"11","value":"نوفمر"},{"key":"12","value":"ديسمبر"}],"days":[{"key":"04","value":"الأثنين"},{"key":"05","value":"الثلاثاء"},{"key":"06","value":"الأربع"},{"key":"07","value":"الخميس"},{"key":"08","value":"الجمعة"},{"key":"09","value":"السبت"},{"key":"10","value":"الأحد"},{"key":"11","value":"الأثنين"},{"key":"12","value":"الثلاثاء"},{"key":"13","value":"الأربع"},{"key":"14","value":"الخميس"},{"key":"15","value":"الجمعة"},{"key":"16","value":"السبت"},{"key":"17","value":"الأحد"},{"key":"18","value":"الأثنين"},{"key":"19","value":"الثلاثاء"},{"key":"20","value":"الأربع"},{"key":"21","value":"الخميس"},{"key":"22","value":"الجمعة"},{"key":"23","value":"السبت"},{"key":"24","value":"الأحد"},{"key":"25","value":"الأثنين"},{"key":"26","value":"الثلاثاء"},{"key":"27","value":"الأربع"},{"key":"28","value":"الخميس"}],"times":[{"key":"06:00:00","value":"06:00 صباحاٌ"},{"key":"06:15:00","value":"06:15 صباحاٌ"},{"key":"06:30:00","value":"06:30 صباحاٌ"},{"key":"06:45:00","value":"06:45 صباحاٌ"},{"key":"07:00:00","value":"07:00 صباحاٌ"},{"key":"07:15:00","value":"07:15 صباحاٌ"},{"key":"07:30:00","value":"07:30 صباحاٌ"},{"key":"07:45:00","value":"07:45 صباحاٌ"},{"key":"08:00:00","value":"08:00 صباحاٌ"},{"key":"08:15:00","value":"08:15 صباحاٌ"},{"key":"08:30:00","value":"08:30 صباحاٌ"},{"key":"08:45:00","value":"08:45 صباحاٌ"},{"key":"09:00:00","value":"09:00 صباحاٌ"},{"key":"09:15:00","value":"09:15 صباحاٌ"},{"key":"09:30:00","value":"09:30 صباحاٌ"},{"key":"09:45:00","value":"09:45 صباحاٌ"},{"key":"10:00:00","value":"10:00 صباحاٌ"},{"key":"10:15:00","value":"10:15 صباحاٌ"},{"key":"10:30:00","value":"10:30 صباحاٌ"},{"key":"10:45:00","value":"10:45 صباحاٌ"},{"key":"11:00:00","value":"11:00 صباحاٌ"},{"key":"11:15:00","value":"11:15 صباحاٌ"},{"key":"11:30:00","value":"11:30 صباحاٌ"},{"key":"11:45:00","value":"11:45 صباحاٌ"},{"key":"12:00:00","value":"12:00 مساءاٌ"},{"key":"12:15:00","value":"12:15 مساءاٌ"},{"key":"12:30:00","value":"12:30 مساءاٌ"},{"key":"12:45:00","value":"12:45 مساءاٌ"},{"key":"13:00:00","value":"01:00 مساءاٌ"},{"key":"13:15:00","value":"01:15 مساءاٌ"},{"key":"13:30:00","value":"01:30 مساءاٌ"},{"key":"13:45:00","value":"01:45 مساءاٌ"},{"key":"14:00:00","value":"02:00 مساءاٌ"},{"key":"14:15:00","value":"02:15 مساءاٌ"},{"key":"14:30:00","value":"02:30 مساءاٌ"},{"key":"14:45:00","value":"02:45 مساءاٌ"},{"key":"15:00:00","value":"03:00 مساءاٌ"},{"key":"15:15:00","value":"03:15 مساءاٌ"},{"key":"15:30:00","value":"03:30 مساءاٌ"},{"key":"15:45:00","value":"03:45 مساءاٌ"},{"key":"16:00:00","value":"04:00 مساءاٌ"},{"key":"16:15:00","value":"04:15 مساءاٌ"},{"key":"16:30:00","value":"04:30 مساءاٌ"},{"key":"16:45:00","value":"04:45 مساءاٌ"},{"key":"17:00:00","value":"05:00 مساءاٌ"},{"key":"17:15:00","value":"05:15 مساءاٌ"},{"key":"17:30:00","value":"05:30 مساءاٌ"},{"key":"17:45:00","value":"05:45 مساءاٌ"},{"key":"18:00:00","value":"06:00 مساءاٌ"},{"key":"18:15:00","value":"06:15 مساءاٌ"},{"key":"18:30:00","value":"06:30 مساءاٌ"},{"key":"18:45:00","value":"06:45 مساءاٌ"}]}

class DelayDateModel {
  DelayDateModel({
      Data? data,}){
    _data = data;
}

  DelayDateModel.fromJson(dynamic json) {
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

/// months : [{"key":"04","value":"ابريل"},{"key":"05","value":"مايو"},{"key":"06","value":"يونيو"},{"key":"07","value":"يوليو"},{"key":"08","value":"أغسطس"},{"key":"09","value":"سبتمبر"},{"key":"10","value":"أكتوبر"},{"key":"11","value":"نوفمر"},{"key":"12","value":"ديسمبر"}]
/// days : [{"key":"04","value":"الأثنين"},{"key":"05","value":"الثلاثاء"},{"key":"06","value":"الأربع"},{"key":"07","value":"الخميس"},{"key":"08","value":"الجمعة"},{"key":"09","value":"السبت"},{"key":"10","value":"الأحد"},{"key":"11","value":"الأثنين"},{"key":"12","value":"الثلاثاء"},{"key":"13","value":"الأربع"},{"key":"14","value":"الخميس"},{"key":"15","value":"الجمعة"},{"key":"16","value":"السبت"},{"key":"17","value":"الأحد"},{"key":"18","value":"الأثنين"},{"key":"19","value":"الثلاثاء"},{"key":"20","value":"الأربع"},{"key":"21","value":"الخميس"},{"key":"22","value":"الجمعة"},{"key":"23","value":"السبت"},{"key":"24","value":"الأحد"},{"key":"25","value":"الأثنين"},{"key":"26","value":"الثلاثاء"},{"key":"27","value":"الأربع"},{"key":"28","value":"الخميس"}]
/// times : [{"key":"06:00:00","value":"06:00 صباحاٌ"},{"key":"06:15:00","value":"06:15 صباحاٌ"},{"key":"06:30:00","value":"06:30 صباحاٌ"},{"key":"06:45:00","value":"06:45 صباحاٌ"},{"key":"07:00:00","value":"07:00 صباحاٌ"},{"key":"07:15:00","value":"07:15 صباحاٌ"},{"key":"07:30:00","value":"07:30 صباحاٌ"},{"key":"07:45:00","value":"07:45 صباحاٌ"},{"key":"08:00:00","value":"08:00 صباحاٌ"},{"key":"08:15:00","value":"08:15 صباحاٌ"},{"key":"08:30:00","value":"08:30 صباحاٌ"},{"key":"08:45:00","value":"08:45 صباحاٌ"},{"key":"09:00:00","value":"09:00 صباحاٌ"},{"key":"09:15:00","value":"09:15 صباحاٌ"},{"key":"09:30:00","value":"09:30 صباحاٌ"},{"key":"09:45:00","value":"09:45 صباحاٌ"},{"key":"10:00:00","value":"10:00 صباحاٌ"},{"key":"10:15:00","value":"10:15 صباحاٌ"},{"key":"10:30:00","value":"10:30 صباحاٌ"},{"key":"10:45:00","value":"10:45 صباحاٌ"},{"key":"11:00:00","value":"11:00 صباحاٌ"},{"key":"11:15:00","value":"11:15 صباحاٌ"},{"key":"11:30:00","value":"11:30 صباحاٌ"},{"key":"11:45:00","value":"11:45 صباحاٌ"},{"key":"12:00:00","value":"12:00 مساءاٌ"},{"key":"12:15:00","value":"12:15 مساءاٌ"},{"key":"12:30:00","value":"12:30 مساءاٌ"},{"key":"12:45:00","value":"12:45 مساءاٌ"},{"key":"13:00:00","value":"01:00 مساءاٌ"},{"key":"13:15:00","value":"01:15 مساءاٌ"},{"key":"13:30:00","value":"01:30 مساءاٌ"},{"key":"13:45:00","value":"01:45 مساءاٌ"},{"key":"14:00:00","value":"02:00 مساءاٌ"},{"key":"14:15:00","value":"02:15 مساءاٌ"},{"key":"14:30:00","value":"02:30 مساءاٌ"},{"key":"14:45:00","value":"02:45 مساءاٌ"},{"key":"15:00:00","value":"03:00 مساءاٌ"},{"key":"15:15:00","value":"03:15 مساءاٌ"},{"key":"15:30:00","value":"03:30 مساءاٌ"},{"key":"15:45:00","value":"03:45 مساءاٌ"},{"key":"16:00:00","value":"04:00 مساءاٌ"},{"key":"16:15:00","value":"04:15 مساءاٌ"},{"key":"16:30:00","value":"04:30 مساءاٌ"},{"key":"16:45:00","value":"04:45 مساءاٌ"},{"key":"17:00:00","value":"05:00 مساءاٌ"},{"key":"17:15:00","value":"05:15 مساءاٌ"},{"key":"17:30:00","value":"05:30 مساءاٌ"},{"key":"17:45:00","value":"05:45 مساءاٌ"},{"key":"18:00:00","value":"06:00 مساءاٌ"},{"key":"18:15:00","value":"06:15 مساءاٌ"},{"key":"18:30:00","value":"06:30 مساءاٌ"},{"key":"18:45:00","value":"06:45 مساءاٌ"}]

class Data {
  Data({
      List<Months>? months, 
      List<Days>? days, 
      List<Times>? times,}){
    _months = months;
    _days = days;
    _times = times;
}

  Data.fromJson(dynamic json) {
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
  }
  List<Months>? _months;
  List<Days>? _days;
  List<Times>? _times;

  List<Months>? get months => _months;
  List<Days>? get days => _days;
  List<Times>? get times => _times;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_months != null) {
      map['months'] = _months?.map((v) => v.toJson()).toList();
    }
    if (_days != null) {
      map['days'] = _days?.map((v) => v.toJson()).toList();
    }
    if (_times != null) {
      map['times'] = _times?.map((v) => v.toJson()).toList();
    }
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

/// key : "04"
/// value : "الأثنين"

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

/// key : "04"
/// value : "ابريل"

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