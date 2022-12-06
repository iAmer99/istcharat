/// data : {"rows":[{"key":"emergency_consultations","value":"إستشارات طارئة"},{"key":"video_consultations","value":"إستشارات فيديو"},{"key":"voice_consultations","value":"إستشارات صوتية"},{"key":"chat_consultations","value":"إستشارات نصية"},{"key":"faqs","value":"الأسئلة والأجوبة"},{"key":"appointment_consultations","value":"مواعيد العيادة"}]}

class LogsCategoriesModel {
  LogsCategoriesModel({
      Data? data,}){
    _data = data;
}

  LogsCategoriesModel.fromJson(dynamic json) {
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

/// rows : [{"key":"emergency_consultations","value":"إستشارات طارئة"},{"key":"video_consultations","value":"إستشارات فيديو"},{"key":"voice_consultations","value":"إستشارات صوتية"},{"key":"chat_consultations","value":"إستشارات نصية"},{"key":"faqs","value":"الأسئلة والأجوبة"},{"key":"appointment_consultations","value":"مواعيد العيادة"}]

class Data {
  Data({
      List<Rows>? rows,}){
    _rows = rows;
}

  Data.fromJson(dynamic json) {
    if (json['rows'] != null) {
      _rows = [];
      json['rows'].forEach((v) {
        _rows?.add(Rows.fromJson(v));
      });
    }
  }
  List<Rows>? _rows;

  List<Rows>? get rows => _rows;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_rows != null) {
      map['rows'] = _rows?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// key : "emergency_consultations"
/// value : "إستشارات طارئة"

class Rows {
  Rows({
      String? key, 
      String? value,}){
    _key = key;
    _value = value;
}

  Rows.fromJson(dynamic json) {
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