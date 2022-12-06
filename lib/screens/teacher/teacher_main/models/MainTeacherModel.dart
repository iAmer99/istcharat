/// data : [{"category_key":"emergency_consultations","icon":"https://api-istchrat.mazadak.net/icons/book.png","type":"إستشارات طارئة","total":6,"current_month":0,"current_day":0},{"category_key":"video_consultations","icon":"https://api-istchrat.mazadak.net/icons/video.png","type":"إستشارات فيديو","total":1,"current_month":0,"current_day":0},{"category_key":"voice_consultations","icon":"https://api-istchrat.mazadak.net/icons/voice.png","type":"إستشارات صوتية","total":1,"current_month":0,"current_day":0},{"category_key":"chat_consultations","icon":"https://api-istchrat.mazadak.net/icons/chat.png","type":"إستشارات نصية","total":1,"current_month":0,"current_day":0},{"category_key":"online_courses","icon":"https://api-istchrat.mazadak.net/icons/course.png","type":"دوارات أونلاين","total":4,"current_month":0,"current_day":0},{"category_key":"offline_courses","icon":"https://api-istchrat.mazadak.net/icons/course.png","type":"دوارات مسجلة","total":4,"current_month":0,"current_day":0},{"category_key":"books","icon":"https://api-istchrat.mazadak.net/icons/book.png","type":"الكتب والمؤلفات","total":5,"current_month":0,"current_day":0},{"category_key":"faqs","icon":"https://api-istchrat.mazadak.net/icons/faq.png","type":"الأسئلة والأجوبة","total":11,"current_month":0,"current_day":0},{"category_key":"appointment_consultations","icon":"https://api-istchrat.mazadak.net/icons/book.png","type":"مواعيد العيادة","total":1,"current_month":0,"current_day":0}]

class MainTeacherModel {
  MainTeacherModel({
      List<Data>? data,}){
    _data = data;
}

  MainTeacherModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? _data;
MainTeacherModel copyWith({  List<Data>? data,
}) => MainTeacherModel(  data: data ?? _data,
);
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// category_key : "emergency_consultations"
/// icon : "https://api-istchrat.mazadak.net/icons/book.png"
/// type : "إستشارات طارئة"
/// total : 6
/// current_month : 0
/// current_day : 0

class Data {
  Data({
      String? categoryKey, 
      String? icon, 
      String? type, 
      int? total, 
      int? currentMonth, 
      int? currentDay,}){
    _categoryKey = categoryKey;
    _icon = icon;
    _type = type;
    _total = total;
    _currentMonth = currentMonth;
    _currentDay = currentDay;
}

  Data.fromJson(dynamic json) {
    _categoryKey = json['category_key'];
    _icon = json['icon'];
    _type = json['type'];
    _total = json['total'];
    _currentMonth = json['current_month'];
    _currentDay = json['current_day'];
  }
  String? _categoryKey;
  String? _icon;
  String? _type;
  int? _total;
  int? _currentMonth;
  int? _currentDay;
Data copyWith({  String? categoryKey,
  String? icon,
  String? type,
  int? total,
  int? currentMonth,
  int? currentDay,
}) => Data(  categoryKey: categoryKey ?? _categoryKey,
  icon: icon ?? _icon,
  type: type ?? _type,
  total: total ?? _total,
  currentMonth: currentMonth ?? _currentMonth,
  currentDay: currentDay ?? _currentDay,
);
  String? get categoryKey => _categoryKey;
  String? get icon => _icon;
  String? get type => _type;
  int? get total => _total;
  int? get currentMonth => _currentMonth;
  int? get currentDay => _currentDay;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_key'] = _categoryKey;
    map['icon'] = _icon;
    map['type'] = _type;
    map['total'] = _total;
    map['current_month'] = _currentMonth;
    map['current_day'] = _currentDay;
    return map;
  }

}