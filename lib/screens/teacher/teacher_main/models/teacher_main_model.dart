/// data : [{"icon":"https://api-istchrat.mazadak.net/icons/book.svg","type":"إستشارات طارئة","total":6,"current_month":6,"current_day":0},{"icon":"https://api-istchrat.mazadak.net/icons/video.svg","type":"إستشارات فيديو","total":1,"current_month":1,"current_day":0},{"icon":"https://api-istchrat.mazadak.net/icons/voice.svg","type":"إستشارات صوتية","total":1,"current_month":1,"current_day":0},{"icon":"https://api-istchrat.mazadak.net/icons/chat.svg","type":"إستشارات نصية","total":1,"current_month":1,"current_day":0},{"icon":"https://api-istchrat.mazadak.net/icons/course.svg","type":"دوارات أونلاين","total":4,"current_month":4,"current_day":0},{"icon":"https://api-istchrat.mazadak.net/icons/course.svg","type":"دوارات مسجلة","total":4,"current_month":4,"current_day":0},{"icon":"https://api-istchrat.mazadak.net/icons/book.svg","type":"الكتب والمؤلفات","total":5,"current_month":5,"current_day":0},{"icon":"https://api-istchrat.mazadak.net/icons/faq.svg","type":"الأسئلة والأجوبة","total":11,"current_month":11,"current_day":0},{"icon":"https://api-istchrat.mazadak.net/icons/book.svg","type":"مواعيد العيادة","total":1,"current_month":1,"current_day":0}]

class TeacherMainModel {
  List<Teacherdata>? data;

  TeacherMainModel({
      this.data});

  TeacherMainModel.fromJson(dynamic json) {
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data!.add(Teacherdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      map["data"] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// icon : "https://api-istchrat.mazadak.net/icons/book.svg"
/// type : "إستشارات طارئة"
/// total : 6
/// current_month : 6
/// current_day : 0

class Teacherdata {
  String? icon;
  String? type;
  int? total;
  int? currentMonth;
  int? currentDay;

  Teacherdata({
      this.icon, 
      this.type, 
      this.total, 
      this.currentMonth, 
      this.currentDay});

  Teacherdata.fromJson(dynamic json) {
    icon = json["icon"];
    type = json["type"];
    total = json["total"];
    currentMonth = json["current_month"];
    currentDay = json["current_day"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["icon"] = icon;
    map["type"] = type;
    map["total"] = total;
    map["current_month"] = currentMonth;
    map["current_day"] = currentDay;
    return map;
  }

}