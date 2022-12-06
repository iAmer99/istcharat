/// data : {"lecturer":{"image":"https://api-istchrat.mazadak.net/uploads/lecturers/2022-03-07-07-42-18-06226601a7f77a.png","name":"د. مصطفي أبو سعد","position":"أستشاري نفسي وتربوي ومن رواد العالم العربي","university":"جامعة العلوم والإقتصاد"},"appointment":{"question":"ask your quesiton here ?","answer":null},"results":{"consultationType":"الأسئلة والأجوبة","consultationFee":"1.00","taxFee":"0.10","totalGrand":"1.10","currency":"دينار"}}

class ConfirmQuestionAnswerModel {
  ConfirmQuestionAnswerModel({
      Data? data,}){
    _data = data;
}

  ConfirmQuestionAnswerModel.fromJson(dynamic json) {
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
/// appointment : {"question":"ask your quesiton here ?","answer":null}
/// results : {"consultationType":"الأسئلة والأجوبة","consultationFee":"1.00","taxFee":"0.10","totalGrand":"1.10","currency":"دينار"}

class Data {
  Data({
      Lecturer? lecturer, 
      Appointment? appointment, 
      Results? results,}){
    _lecturer = lecturer;
    _appointment = appointment;
    _results = results;
}

  Data.fromJson(dynamic json) {
    _lecturer = json['lecturer'] != null ? Lecturer.fromJson(json['lecturer']) : null;
    _appointment = json['appointment'] != null ? Appointment.fromJson(json['appointment']) : null;
    _results = json['results'] != null ? Results.fromJson(json['results']) : null;
  }
  Lecturer? _lecturer;
  Appointment? _appointment;
  Results? _results;

  Lecturer? get lecturer => _lecturer;
  Appointment? get appointment => _appointment;
  Results? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_lecturer != null) {
      map['lecturer'] = _lecturer?.toJson();
    }
    if (_appointment != null) {
      map['appointment'] = _appointment?.toJson();
    }
    if (_results != null) {
      map['results'] = _results?.toJson();
    }
    return map;
  }

}

/// consultationType : "الأسئلة والأجوبة"
/// consultationFee : "1.00"
/// taxFee : "0.10"
/// totalGrand : "1.10"
/// currency : "دينار"

class Results {
  Results({
      String? consultationType, 
      String? consultationFee, 
      String? taxFee, 
      String? totalGrand, 
      String? currency,}){
    _consultationType = consultationType;
    _consultationFee = consultationFee;
    _taxFee = taxFee;
    _totalGrand = totalGrand;
    _currency = currency;
}

  Results.fromJson(dynamic json) {
    _consultationType = json['consultationType'];
    _consultationFee = json['consultationFee'];
    _taxFee = json['taxFee'];
    _totalGrand = json['totalGrand'];
    _currency = json['currency'];
  }
  String? _consultationType;
  String? _consultationFee;
  String? _taxFee;
  String? _totalGrand;
  String? _currency;

  String? get consultationType => _consultationType;
  String? get consultationFee => _consultationFee;
  String? get taxFee => _taxFee;
  String? get totalGrand => _totalGrand;
  String? get currency => _currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['consultationType'] = _consultationType;
    map['consultationFee'] = _consultationFee;
    map['taxFee'] = _taxFee;
    map['totalGrand'] = _totalGrand;
    map['currency'] = _currency;
    return map;
  }

}

/// question : "ask your quesiton here ?"
/// answer : null

class Appointment {
  Appointment({
      String? question, 
      dynamic answer,}){
    _question = question;
    _answer = answer;
}

  Appointment.fromJson(dynamic json) {
    _question = json['question'];
    _answer = json['answer'];
  }
  String? _question;
  dynamic _answer;

  String? get question => _question;
  dynamic get answer => _answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = _question;
    map['answer'] = _answer;
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